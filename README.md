# workspace-setup

This repository contains the setup code for deploying my workspace environment, predominantly on macOS.

## Running Instructions
```bash
./setup_mac.sh
```

## Technical Information
The setup script performs the following actions;

1. Installs [Homebrew](https://brew.sh) if it is not already installed.
2. Installs Python 3 from Homebrew if it is not already installed.
3. Installs Ansible from Homebrew if it is not already installed.
4. Execute the playbook `macbook.yml`.

The playbook then installs numerous Homebrew formulae and casks.

## Todo
- Configuration management
- Dotfile management
- System Updates
