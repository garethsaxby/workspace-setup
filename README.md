# workspace-setup

This repository contains the setup code for deploying my workspace environment on macOS.

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

The playbook then performs the following:

1. Installs the required Homebrew Taps.
2. Updates Homebrew.
3. Installs the set Brew formulae.
4. Installs the set Brew Casks.
5. Installs set App Store packages using [mas](https://github.com/mas-cli/mas).
6. Creates folder for Dotfile storage.
7. Clones Dotfiles ready for linking.

## Todo

- Configuration management for macOS applications; can be somewhat complicated to implement, so likely only for a small set of core applications.
- Manage system updates; traditionally I've used a simple shell script for this.
- Upgrade homebrew_cask to use collections-based version; currently, several casks fail when using community.general.homebrew_cask as their names are no longer recognised due to being hyphenated.
- Automatically run the linking script for my Dotfiles.

