import json
import os
import re
import tempfile
import subprocess
import shutil
from jinja2 import Environment, FileSystemLoader

class Importer:
    def __init__(self):
        self.RESOURCES = {}
        self.source_url = ""
        self.source_dir = ""

    def load_resources(self):
        file_path = 'import.json'

        try:
            with open(file_path, 'r') as file:
                self.RESOURCES = json.load(file)
                print("Resources loaded successfully.")
        except FileNotFoundError:
            print(f"Error: File '{file_path}' not found.")
        except json.JSONDecodeError as e:
            print(f"Error decoding JSON: {e}")


    def name_from_id(self, resource_id):
        if not resource_id:
            return None
        parts = resource_id.strip('/').split('/')
        return parts[-1] if len(parts) >= 2 else None
    
    def folder_from_source(self, name, source):
        parts = source.strip('/').split('/')
        folder_name = parts[-3] if len(parts) >= 2 else None
        # os.makedirs("f'{folder_name}/f'{name}", exist_ok=True)
        return "f'{folder_name}/f'{name}"
    
    def source_repo(self, url, dir):
        try:
            subprocess.run(["git", "clone", url, dir], check=True)
            print(f"Cloned source repo to: {dir}")
        except subprocess.CalledProcessError as e:
            print(f"Failed to clone repository: {e}")
            exit(1)        


    """ 
    def extract_keys_from_resource_blocks(self, tf_content):
        resource_blocks = re.findall(r'resource\s+".*?"\s+".*?"\s*{(.*?)}', tf_content, re.DOTALL)
        keys = set()

        for block in resource_blocks:
            for line in block.splitlines():
                line = line.strip()
                if line and "=" in line and not line.startswith("#") and not line.startswith("dynamic"):
                    key = line.split('=')[0].strip()
                    if key:
                        keys.add(key)
        
        return sorted(keys)




    def parse_main_tf_files(self, source_dir):
        result = []

        for root, dirs, files in os.walk(source_dir):
            for file in files:
                if file == "main.tf":
                    file_path = os.path.join(root, file)
                    with open(file_path, 'r') as f:
                        content = f.read()

                    keys = self.extract_keys_from_resource_blocks(content)
                    rel_path = os.path.relpath(file_path, source_dir)
                    # result = [rel_path]
                    return result.append(keys) """
                



    def generate_context(self, resource, source_dir):
        context = {}

        keys = self.parse_main_tf_files(source_dir)     # Look up az cli for the populated attributes and form context

        for i in range(len(keys)):
            context['inputs'] = {f"{keys[i]}" : "" for i in range(len(keys))}



            # Look up az cli metadata to assign to f'{keys[i]}



        context['dependencies'] = [] # given the dep name, go two dir back and find imported resource with that name and config the rel path
        


    def render_hcl(template_name, output_path, context):
        env = Environment(loader=FileSystemLoader("template"))
        template = env.get_template(template_name)


        rendered_content = template.render(context)

        #     # Example context
        #     context = {
        #         "name": "my-subnet",
        #         "location": "eastus2",
        #         "tags": '{"env" = "dev"}',
        #         "resource_group_name": "my-rg"
        #     }

        os.makedirs(os.path.dirname(output_path), exist_ok=True)

        with open(output_path, 'w') as f:
            f.write(rendered_content)

        print(f"HCL file written to {output_path}")





    def import_(self, name):

        for resource in self.RESOURCES:
            if resource['name'] == name:
                r_name = self.name_from_id(resource['id'])
                folder_path = self.folder_from_source(r_name, resource['source'])
                context = self.generate_context(resource)
                self.render_hcl('terragrunt.hcl.j2', folder_path, context)
                # self.render_hcl('terragrunt.hcl.j2', self.folder_from_source(self.name_from_id(resource['id']), resource['source']), self.generate_context(resource))



        






def main():

    source_url = ""
    source_dir = "" 

    print("Welcome")
    importer = Importer()
    importer.source_repo(source_url, source_dir)
    # importer.render_hcl("terragrunt.hcl.j2", "generated/subnet/terragrunt.hcl", context)
    # importer.start()

if __name__ == "__main__":
    main()
