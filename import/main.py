import json
import os
import re
import subprocess
from jinja2 import Environment, FileSystemLoader

class Importer:
    def __init__(self):
        # Dictionary to hold resource details loaded from import.json
        self.RESOURCES = {}
        self.source_url = ""     # Git repo URL (can be set later)
        self.source_dir = ""     # Local directory to clone into

    def load_resources(self):
        """
        Load the resources from 'import.json' into the RESOURCES dictionary.
        """
        file_path = 'import.json'
        try:
            with open(file_path, 'r') as file:
                self.RESOURCES = json.load(file)
                print(f"[DEBUG] Loaded {len(self.RESOURCES)} resources from '{file_path}'")
        except FileNotFoundError:
            print(f"[ERROR] File '{file_path}' not found.")
        except json.JSONDecodeError as e:
            print(f"[ERROR] Error decoding JSON: {e}")

    def name_from_id(self, resource_id):
        """
        Extract the last segment (usually name) from a resource ID.
        Example: '/subscriptions/xxx/resourceGroups/rg/providers/Microsoft.Network/virtualNetworks/vnet1'
        → 'vnet1'
        """
        if not resource_id:
            return None
        parts = resource_id.strip('/').split('/')
        name = parts[-1] if len(parts) >= 2 else None
        print(f"[DEBUG] Extracted name '{name}' from resource ID '{resource_id}'")
        return name

    def folder_from_source(self, name, source):
        """
        Derive a folder path using a portion of the source path and resource name.
        Example: source='modules/azure/virtual-network/main.tf', name='vnet1'
        → 'virtual-network/vnet1'
        """
        parts = source.strip('/').split('/')
        folder_name = parts[-3] if len(parts) >= 3 else "default"
        folder = f"{folder_name}/{name}"
        print(f"[DEBUG] Derived folder path '{folder}'")
        return folder

    def source_repo(self, url, dir):
        """
        Clone the Terraform source repo from GitHub to a local directory.
        """
        print(f"[INFO] Cloning repo from '{url}' to '{dir}'")
        try:
            subprocess.run(["git", "clone", url, dir], check=True)
            print(f"[DEBUG] Cloned repository successfully.")
        except subprocess.CalledProcessError as e:
            print(f"[ERROR] Failed to clone repository: {e}")
            exit(1)

    def flatten_values(self, d):
        """
        Recursively flatten all values in a nested dict/list to a single list of values.
        Used to extract potential dependencies from resource properties.
        """
        result = []
        if isinstance(d, dict):
            for v in d.values():
                result.extend(self.flatten_values(v))
        elif isinstance(d, list):
            for item in d:
                result.extend(self.flatten_values(item))
        elif isinstance(d, str):
            result.append(d)
        return result

    def extract_dynamic_dependencies(self, current_id, metadata):
        """
        Look for names of other resources in the current resource's metadata.
        Returns a list of names this resource may depend on.
        """
        print(f"[INFO] Extracting dynamic dependencies for {current_id}")
        all_values = self.flatten_values(metadata)
        dependencies = []

        for res in self.RESOURCES:
            if res['id'] != current_id:
                name = self.name_from_id(res['id'])
                if name and any(name in v for v in all_values if isinstance(v, str)):
                    dependencies.append(name)
                    print(f"[DEBUG] Found dynamic dependency: {name}")

        return dependencies

    def get_resource_attributes(self, resource_id):
        """
        Uses Azure CLI to fetch resource properties (non-null attributes).
        """
        print(f"[INFO] Fetching resource attributes via Azure CLI for ID: {resource_id}")
        try:
            result = subprocess.run(
                ["az", "resource", "show", "--ids", resource_id, "--output", "json"],
                check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
            )
            data = json.loads(result.stdout)
            props = data.get('properties', {})
            print(f"[DEBUG] Retrieved {len(props)} attributes for resource.")
            return props
        except subprocess.CalledProcessError as e:
            print(f"[ERROR] Failed to fetch attributes for {resource_id}: {e.stderr}")
            return {}

    def generate_context(self, resource):
        """
        Generate context (inputs + dependencies) for rendering the template.
        """
        print(f"[INFO] Generating context for resource '{resource['name']}'")
        context = {}
        resource_id = resource.get("id")
        if not resource_id:
            print("[WARN] Resource has no ID, skipping...")
            return context

        metadata = self.get_resource_attributes(resource_id)

        # Filter out only non-empty attributes
        keys = [k for k, v in metadata.items() if v not in [None, {}, [], ""]]
        context["inputs"] = {k: metadata.get(k, "") for k in keys}
        print(f"[DEBUG] Inputs: {context['inputs']}")

        # Dynamic dependency detection
        dep_names = self.extract_dynamic_dependencies(resource_id, metadata)
        context["dependencies"] = dep_names
        print(f"[DEBUG] Dependencies: {context['dependencies']}")

        return context

    def render_hcl(self, template_name, output_path, context):
        """
        Render a HCL file from Jinja2 template using given context and save it.
        """
        print(f"[INFO] Rendering HCL to {output_path}")
        env = Environment(loader=FileSystemLoader("template"))
        template = env.get_template(template_name)
        rendered_content = template.render(context)

        os.makedirs(os.path.dirname(output_path), exist_ok=True)
        with open(output_path, 'w') as f:
            f.write(rendered_content)

        print(f"[SUCCESS] HCL file written to '{output_path}'")

    def import_(self, name):
        """
        Process a single resource (by name) from the resource list.
        """
        print(f"[INFO] Starting import of resource: {name}")
        for resource in self.RESOURCES:
            if resource['name'] == name:
                r_name = self.name_from_id(resource['id'])
                folder_path = self.folder_from_source(r_name, resource['source'])
                context = self.generate_context(resource)
                self.render_hcl('terragrunt.hcl.j2', f"{folder_path}/terragrunt.hcl", context)
                return
        print(f"[WARN] Resource with name '{name}' not found in import.json")

def main():
    print("======== Terraform Import Automation ========")
    importer = Importer()

    # Step 1: Load JSON resource metadata
    importer.load_resources()

    # Step 2: Optionally clone the source repo if needed
    # importer.source_repo("https://github.com/your/repo", "source_code")

    # Step 3: Import a specific resource (replace with your actual resource name)
    importer.import_("your-resource-name")

if __name__ == "__main__":
    main()
