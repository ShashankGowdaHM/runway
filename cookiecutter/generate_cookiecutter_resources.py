import os
import json
import argparse
import subprocess
import yaml
from jinja2 import Template

RESOURCE_FILE = "cookiecutter_resources.json"
RESOURCE_MAPPING_FILE = "resource_mapping.yaml"


def run_cli(cmd):
    result = subprocess.run(cmd, capture_output=True, text=True, shell=True)
    if result.returncode != 0:
        raise RuntimeError(f"[ERROR] CLI failed: {result.stderr}")
    return json.loads(result.stdout)


def load_yaml(file_path):
    with open(file_path, "r") as f:
        return yaml.safe_load(f)


def load_existing_cookiecutter_resources():
    if os.path.exists(RESOURCE_FILE):
        with open(RESOURCE_FILE, "r") as f:
            return json.load(f)
    return []


def save_cookiecutter_resources(data):
    with open(RESOURCE_FILE, "w") as f:
        json.dump(data, f, indent=2)


def parse_resource_info(resource_id):
    metadata = run_cli(f"az resource show --ids {resource_id}")
    return {
        "id": resource_id,
        "type": metadata["type"],
        "name": metadata["name"],
        "location": metadata["location"],
        "resource_group": metadata["resourceGroup"],
        "full_metadata": metadata,
    }


def build_resource_entry(metadata, mappings):
    resource_type = metadata["type"]

    if resource_type not in mappings:
        raise ValueError(f"[ERROR] Resource type '{resource_type}' not found in mapping.")

    mapping = mappings[resource_type]
    print(f"[DEBUG] Using mapping for {resource_type}: {mapping}")

    # Extract common parts
    resource_name = mapping.get("resource_name", metadata["name"])
    module_path = mapping["module_path"]

    # Create context for template rendering
    template_context = {
        "env": extract_env(metadata["resource_group"]),
        "resource_group": metadata["resource_group"],
        "location": metadata["location"],
        "vnet_name": metadata["full_metadata"].get("name", ""),
        "subnet_name": metadata["full_metadata"].get("name", ""),
        "nsg_name": metadata["full_metadata"].get("name", ""),
        "storage_name": metadata["full_metadata"].get("name", ""),
    }

    folder_template = Template(mapping["folder_path"])
    folder_path = folder_template.render(template_context)

    entry = {
        "resource_type": resource_type,
        "resource_id": metadata["id"],
        "resource_name": resource_name,
        "module_path": module_path,
        "folder_path": folder_path,
        "inputs": {
            "name": metadata["name"],
            "resource_group_name": metadata["resource_group"],
            "location": metadata["location"],
        },
    }

    return entry


def extract_env(resource_group_name):
    parts = resource_group_name.split("-")
    return parts[1] if len(parts) > 1 else "env"


def add_resource_by_id(resource_id, mappings):
    print(f"[INFO] Fetching metadata for: {resource_id}")
    metadata = parse_resource_info(resource_id)
    entry = build_resource_entry(metadata, mappings)

    existing = load_existing_cookiecutter_resources()
    if not any(e["resource_id"] == entry["resource_id"] for e in existing):
        existing.append(entry)
        save_cookiecutter_resources(existing)
        print(f"[INFO] Added resource to {RESOURCE_FILE}")
    else:
        print("[INFO] Resource already present.")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--resource-id", help="Azure resource ID to add")
    args = parser.parse_args()

    # Load mapping
    mappings = load_yaml(RESOURCE_MAPPING_FILE)

    if args.resource_id:
        add_resource_by_id(args.resource_id, mappings)
    else:
        print("[ERROR] --resource-id is required")


if __name__ == "__main__":
    main()
