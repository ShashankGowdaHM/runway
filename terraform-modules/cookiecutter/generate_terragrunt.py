from jinja2 import Environment, FileSystemLoader
import os
import json

# Constants
CONFIG_PATH = "cookiecutter_resources.json"  # JSON input file with resource configs
TEMPLATE_DIR = "terragrunt_template"         # Folder where .j2 template exists
OUTPUT_BASE = "."                            # Root folder to create resource folders

def render_template(template_file, output_path, context, resource):
    print(f"[INFO] Loading template environment from: {TEMPLATE_DIR}")
    env = Environment(loader=FileSystemLoader(TEMPLATE_DIR))

    print(f"[INFO] Getting template: {template_file}")
    template = env.get_template(template_file)  # Just the file name, not full path

    print(f"[INFO] Rendering template with context:\n{json.dumps(context, indent=2)}")
    output = template.render(cookiecutter=context)

    print(f"[INFO] Ensuring output directory exists: {os.path.dirname(output_path)}")
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    print(f"[INFO] Writing rendered output to: {output_path}")
    with open(output_path, "w") as f:
        f.write(output)
    print(f"[SUCCESS] Generated: {output_path}")

def main():
    print(f"[INFO] Reading resource config from: {CONFIG_PATH}")
    with open(CONFIG_PATH, "r") as f:
        all_resources = json.load(f)

    for resource_type, resources in all_resources.items():
        print(f"[INFO] Processing resource type: {resource_type}")

        for resource in resources:
            output_dir = os.path.join(OUTPUT_BASE, resource["folder_path"])
            output_file = os.path.join(output_dir, "terragrunt.hcl")

            print(f"[INFO] Checking output file: {output_file}")
            if os.path.exists(output_file):
                print(f"[SKIP] {output_file} already exists.")
                continue

            context = {
                "resource_type": resource_type,
                "module_path": resource["module_path"],
                "resource_name": resource["resource_name"],
                "folder_path": resource["folder_path"],
                "inputs": resource["inputs"],
                "dependencies": resource.get("dependencies", []),
            }

            try:
                render_template("terragrunt.hcl.j2", output_file, context, resource)
            except Exception as e:
                print(f"[ERROR] Failed to generate {output_file}: {e}")

if __name__ == "__main__":
    main()
