import os
import subprocess
import tempfile
import shutil
import sys
import stat
import time

# === CONFIG ===
GITHUB_USERNAME = "ShashankGowdaHM"
GITHUB_TOKEN = "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"
GIT_REPO = f"https://{GITHUB_USERNAME}:{GITHUB_TOKEN}@github.com/ShashankGowdaHM/runway.git"
FILE_PATH = "exec-pipeline.txt"
SHELL_TYPE = "gitbash"  # "gitbash" or "cmd"
BRANCH = "main"

# Detect Git Bash dynamically
GIT_BASH_PATHS = [
    r"C:\Program Files\Git\bin\bash.exe",
    r"C:\Program Files (x86)\Git\bin\bash.exe",
    r"C:\Users\GoSh596\AppData\Local\Programs\Git\bin\bash.exe"
]
GIT_BASH_PATH = next((p for p in GIT_BASH_PATHS if os.path.exists(p)), None)

def run_git_command(args, cwd=None):
    env = os.environ.copy()
    env["GIT_ASKPASS"] = "echo"
    subprocess.check_call(args, cwd=cwd, env=env)

def clone_repo(repo_url, branch):
    temp_dir = tempfile.mkdtemp(prefix="gitrepo_")
    print(f"[INFO] Cloning repo to {temp_dir} ...")
    run_git_command(["git", "clone", "--branch", branch, repo_url, temp_dir])
    return temp_dir

def run_command(command, shell_type):
    if shell_type.lower() == "gitbash":
        if not GIT_BASH_PATH:
            raise FileNotFoundError("Git Bash not found. Please install Git.")
        subprocess.run([GIT_BASH_PATH, "-c", command], check=True)
    elif shell_type.lower() == "cmd":
        subprocess.run(command, shell=True, check=True)
    else:
        raise ValueError("Invalid shell type. Use 'gitbash' or 'cmd'.")

def handle_remove_readonly(func, path, _):
    """Clear the readonly bit and reattempt the removal."""
    os.chmod(path, stat.S_IWRITE)
    func(path)

def safe_rmtree(path):
    """Safely remove a directory even if Windows has locks."""
    time.sleep(1)  # Small delay to let Git release file locks
    try:
        shutil.rmtree(path, onerror=handle_remove_readonly)
    except PermissionError as e:
        print(f"[WARN] Retry deletion due to lock: {e}")
        time.sleep(1)
        shutil.rmtree(path, onerror=handle_remove_readonly)

def main():
    repo_dir = clone_repo(GIT_REPO, BRANCH)
    commands_file = os.path.join(repo_dir, FILE_PATH)

    if not os.path.exists(commands_file):
        print(f"[ERROR] File {commands_file} not found in repo.")
        safe_rmtree(repo_dir)
        sys.exit(1)

    with open(commands_file, "r", encoding="utf-8") as f:
        commands = [line.strip() for line in f if line.strip() and not line.startswith("#")]

    print(f"[INFO] Running {len(commands)} commands sequentially...")
    for cmd in commands:
        print(f"\n[RUN] {cmd}")
        try:
            run_command(cmd, SHELL_TYPE)
        except subprocess.CalledProcessError:
            print(f"[ERROR] Command failed: {cmd}")
            break

    safe_rmtree(repo_dir)
    print("[INFO] Done.")

if __name__ == "__main__":
    main()
