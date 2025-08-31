import os

class FileHandler:
    def __init__(self, files=None, directory=None, recursive=False):
        """
        Either provide:
        - files: list of file paths to edit
        - directory: path to a folder (will collect .md/.txt files)
        """
        if files and directory:
            raise ValueError("Provide either 'files' OR 'directory', not both.")

        if files:
            self.files = [f for f in files if self._is_valid_file(f)]
        elif directory:
            self.files = self._collect_files(directory, recursive)
        else:
            raise ValueError("You must provide either 'files' or 'directory'.")

        if not self.files:
            raise FileNotFoundError("No valid .md or .txt files found.")

    def _is_valid_file(self, filepath):
        """Check file exists and has correct extension"""
        return os.path.isfile(filepath) and filepath.lower().endswith(('.md', '.txt'))

    def _collect_files(self, directory, recursive):
        """Get all .md and .txt files from a directory"""
        collected = []
        if recursive:
            for root, _, files in os.walk(directory):
                for file in files:
                    if file.lower().endswith(('.md')):                      #, '.txt'
                        collected.append(os.path.join(root, file))
        else:
            for file in os.listdir(directory):
                full_path = os.path.join(directory, file)
                if self._is_valid_file(full_path):
                    collected.append(full_path)
        return collected

    def add_prefix(self, prefix_str):
        """Add prefix to each target file"""
        for file in self.files:
            with open(file, 'r', encoding='utf-8') as f:
                content = f.read()
            with open(file, 'w', encoding='utf-8') as f:
                f.write(prefix_str + content)

    def add_suffix(self, suffix_str):
        """Add suffix to each target file"""
        for file in self.files:
            with open(file, 'a', encoding='utf-8') as f:
                f.write(suffix_str)

    def add_prefix_and_suffix(self, prefix_str, suffix_str):
        """Add both prefix and suffix"""
        for file in self.files:
            with open(file, 'r', encoding='utf-8') as f:
                content = f.read()
            with open(file, 'w', encoding='utf-8') as f:
                f.write(prefix_str + content + suffix_str)


# Example usage:

if __name__ == "__main__":
    """ # Option 1: Provide a list of files
    fh1 = FileHandler(files=["doc1.md", "notes.txt"])
    fh3.add_prefix_and_suffix("# Heading\n\n", "\n\n_End_") 

    # Option 2: Process all files in a directory (non-recursive)
    fh2 = FileHandler(directory="./docs", recursive=False)
    fh2.add_suffix("\n---\nEnd of file") """

    # Option 3: Process all files in a directory recursively
    fh = FileHandler(directory=r"C:\Users\GoSh596\Workspace\AIPlatformGitOps", recursive=True)
    fh.add_prefix("**Ownership and maintenance of this document reside with the Operations team. It is strictly for internal Operations purposes and is not intended for clients/partners**\n\n\n")
