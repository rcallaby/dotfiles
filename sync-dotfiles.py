import os
import subprocess
import shutil
import yaml
from pathlib import Path


def load_config(config_path="config.yaml"):
    """Load configuration from YAML file."""
    with open(config_path, "r") as file:
        return yaml.safe_load(file)


def run_command(command, check=True, cwd=None):
    """Run a shell command and return the output."""
    result = subprocess.run(command, shell=True, check=check, cwd=cwd, text=True, capture_output=True)
    return result.stdout.strip()


def install_git():
    """Install Git if not already installed."""
    try:
        run_command("git --version")
        print("Git is already installed.")
    except subprocess.CalledProcessError:
        print("Installing Git...")
        run_command("sudo apt update && sudo apt install git -y")


def clone_dotfiles(repo_url, dotfiles_dir):
    """Clone the bare dotfiles repository."""
    dotfiles_dir = Path(dotfiles_dir).expanduser()
    if dotfiles_dir.exists():
        print(f"The dotfiles directory {dotfiles_dir} already exists. Skipping clone.")
    else:
        print(f"Cloning dotfiles repository from {repo_url} to {dotfiles_dir}...")
        run_command(f"git clone --bare {repo_url} {dotfiles_dir}")


def checkout_dotfiles(dotfiles_dir, backup_dir):
    """Check out the dotfiles repository."""
    dotfiles_dir = Path(dotfiles_dir).expanduser()
    backup_dir = Path(backup_dir).expanduser()

    alias = f'/usr/bin/git --git-dir={dotfiles_dir} --work-tree=$HOME'

    try:
        print("Checking out dotfiles...")
        run_command(f"{alias} checkout")
    except subprocess.CalledProcessError:
        print("Conflicts detected. Backing up existing files...")
        backup_dir.mkdir(parents=True, exist_ok=True)
        conflicts = run_command(f"{alias} checkout 2>&1 || true").splitlines()
        for line in conflicts:
            if line.startswith("error:") and "would be overwritten by checkout" in line:
                file_path = line.split(":")[-1].strip()
                src = Path(file_path).expanduser()
                dst = backup_dir / src.name
                shutil.move(src, dst)
                print(f"Backed up {src} to {dst}")
        run_command(f"{alias} checkout")


def configure_dotfiles(dotfiles_dir):
    """Configure the dotfiles repository to hide untracked files."""
    dotfiles_dir = Path(dotfiles_dir).expanduser()
    alias = f'/usr/bin/git --git-dir={dotfiles_dir} --work-tree=$HOME'
    print("Configuring dotfiles repository...")
    run_command(f"{alias} config --local status.showUntrackedFiles no")


def main():
    # Load configuration
    config = load_config()

    repo_url = config["dotfiles_repo"]
    dotfiles_dir = config["dotfiles_dir"]
    backup_dir = config["backup_dir"]

    # Run steps
    install_git()
    clone_dotfiles(repo_url, dotfiles_dir)
    checkout_dotfiles(dotfiles_dir, backup_dir)
    configure_dotfiles(dotfiles_dir)

    print("Dotfiles setup complete!")


if __name__ == "__main__":
    main()
