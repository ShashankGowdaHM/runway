import os
import json
import subprocess
import tempfile
import shutil
import re
import threading
from queue import Queue
from collections import defaultdict, deque
from jinja2 import Environment, FileSystemLoader

class Importer:
    def __init__(self, token):
        self.RESOURCES = []
        self.token = token
        self.source_url = ""
        self.source_dir = tempfile.mkdtemp(prefix="tf_modules_")
        self.import_order = []
        self.resource_map = {}
        self.context_map = {}

    def load_resources(self):
        file_path = 'import.json'
        try:
            with open(file_path, 'r') as file:
                self.RESOURCES = json.load(file)
                print(f"[DEBUG] Loaded {len(self.RESOURCES)} resources.")
        except Exception as e:
            print(f"Error reading import.json: {e}")
            exit(1)

    def name_from_id(self, resource_id):
        return resource_id.strip('/').split('/')[-1]

    def folder_from_source(self, dest):
        return os.path.join(dest)

    def source_repo(self, url):
        print("[DEBUG] Cloning source repo...")
        if self.token and "github.com" in url:
            url = url.replace("https://", f"https://{self.token}@")
        try:
            subprocess.run(["git", "clone", url, self.source_dir], check=True)
            print(f"[DEBUG] Cloned to: {self.source_dir}")
        except subprocess.CalledProcessError as e:
            print(f"Failed to clone repo: {e}")
            exit(1)

    def extract_resource_blocks(self, tf_content):
        pattern = r'resource\s+"([^"]+)"\s+"([^"]+)"\s*{([^}]|{[^}]*})*}'
        matches = re.finditer(pattern, tf_content, re.DOTALL)
        result = []
        for match in matches:
            resource_type = match.group(1)
            resource_name = match.group(2)
            block = match.group(0)
            keys = set()
            for line in block.splitlines():
                line = line.strip()
                if "=" in line and not line.startswith("#"):
                    keys.add(line.split("=")[0].strip())
            result.append({
                "type": resource_type,
                "name": resource_name,
                "address": f"{resource_type}.{resource_name}",
                "keys": keys
            })
        return result

    def parse_main_tf_files(self):
        results = []
        for root, _, files in os.walk(self.source_dir):
            for file in files:
                if file == "main.tf":
                    with open(os.path.join(root, file)) as f:
                        content = f.read()
                        results.extend(self.extract_resource_blocks(content))
        print(f"[DEBUG] Parsed {len(results)} resource blocks.")
        return results

    def az_lookup(self, resource_id):
        try:
            print(f"[DEBUG] Trying az resource show for: {resource_id}")
            out = subprocess.check_output([
                "az", "resource", "show",
                "--ids", resource_id,
                "--output", "json"
            ])
            return json.loads(out.decode())

        except subprocess.CalledProcessError as e:
            stderr = e.stderr.decode() if hasattr(e, 'stderr') and e.stderr else ''
            print(f"[DEBUG] az resource show failed: {stderr.strip()}")

            # Parse components from resource ID
            parts = resource_id.strip("/").split("/")
            resource_type_parts = parts[6:]
            rg = parts[4]

            # Known fallback: subnet
            if "subnets" in resource_type_parts:
                try:
                    vnet_name = parts[8]
                    subnet_name = parts[10]
                    print(f"[DEBUG] Fallback: az network vnet subnet show for {subnet_name}")
                    out = subprocess.check_output([
                        "az", "network", "vnet", "subnet", "show",
                        "--name", subnet_name,
                        "--vnet-name", vnet_name,
                        "--resource-group", rg,
                        "--output", "json"
                    ])
                    return json.loads(out.decode())
                except Exception as fallback_err:
                    print(f"[ERROR] Subnet fallback failed: {fallback_err}")
                    return {}

            # TODO: Add more fallback types as needed here (NSG, route table, etc.)
            print(f"[ERROR] Resource type fallback not implemented for ID: {resource_id}")
            return {}

        except Exception as e:
            print(f"[ERROR] Unexpected error during az lookup for {resource_id}: {e}")
            return {}


    def generate_context(self, resource, parsed_blocks):
        context = {"inputs": {}, "dependencies": defaultdict(list)}
        resource_id = resource["id"]
        name = resource["name"]
        dest = resource["dest"]

        az_data = self.az_lookup(resource_id)
        print(f"[DEBUG] az_data keys: {list(az_data.keys())}")

        matched_block = None
        for block in parsed_blocks:
            if name.lower() in block["address"].lower():
                matched_block = block
                break

        if matched_block:
            context["import_address"] = matched_block["address"]
            self.resource_map[name] = matched_block["address"]
            print(f"[DEBUG] Found block: {matched_block['address']}")
            for key in matched_block["keys"]:
                val = az_data.get("properties", {}).get(key, az_data.get(key, None))
                context["inputs"][key] = val

        # Dependency detection
        for val in az_data.values():
            if isinstance(val, str) and "/subscriptions/" in val:
                for other in self.RESOURCES:
                    if other['id'].lower() in val.lower() and other['id'].lower() != resource_id.lower():
                        dep_type = other['source'].strip("/").split("/")[-1]  # crude resource type from path
                        context["dependencies"][dep_type].append({
                            "name": other["name"]
                        })

        context["inputs"] = {k: v for k, v in context["inputs"].items() if v is not None}
        print(f"[DEBUG] Inputs: {context['inputs']}")
        print(f"[DEBUG] Dependencies: {context['dependencies']}")
        return context

    def render_hcl(self, output_path, context):
        env = Environment(loader=FileSystemLoader("template"))
        template = env.get_template("terragrunt.hcl.j2")
        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w') as f:
            f.write(template.render(context))
        print(f"[DEBUG] Generated HCL at: {output_path}")

    def start(self):
        self.load_resources()
        self.source_repo(self.source_url)
        blocks = self.parse_main_tf_files()

        for r in self.RESOURCES:
            name = r["name"]
            dest = r["dest"]
            context = self.generate_context(r, blocks)
            self.context_map[name] = context
            tg_path = os.path.join(dest, "terragrunt.hcl")
            self.render_hcl(tg_path, context)

def main():
    git_token = "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"
    importer = Importer(token=git_token)
    importer.source_url = "https://github.azc.ext.hp.com/HPAIP/terraform-modules.git"
    importer.start()

if __name__ == "__main__":
    main()
