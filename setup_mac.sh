#!/usr/bin/env bash
# setup_mash.sh
# Runs all of the required setup to perform macOS setup for my work.
# Configures Homebrew and run Ansible to install all required tools.

# Setting up failure handling
# See http://redsymbol.net/articles/bash-exit-traps/ for details
set -Eeuo pipefail
function fatal_err {
  printf '\nError: See output for details.\n'
}
trap fatal_err ERR

# Text Formatting Setup
# See https://stackoverflow.com/a/4332530 for details
BOLD=$(tput bold)
BLUE=$(tput setaf 153)
NORMAL=$(tput sgr0)

# Standardised print function for output messages
function print {
  printf '%s: %s\n' "${BOLD}${BLUE}$(date '+%Y-%m-%dT%H:%M:%S')${NORMAL}" "$@"
}

function install_homebrew {
  # Test if CLT for XCode is installed, install if not present    
  if ! xcode-select -p 1>/dev/null; then
    print "Installing Command Line Tools for Xcode..."
    xcode-select --install
    print "Command Line Tools for Xcode installed"
  fi

  # Test if Homebrew is installed, install if not present
  if ! [ -x "$(command -v brew)" ]; then
    print "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    print "Homebrew installed"
  fi
}

function install_python {
  # Test if Python 3 is installed, install if not present
  if ! [ -x "$(command -v python3)" ]; then
    print "Installing Python 3..."
    brew install python3
    print "Python 3 installed"
  fi
}

function install_ansible {
  # Test if Ansible is installed, install if not present
  if ! [ -x "$(command -v ansible)" ]; then
    print "Installing Ansible..."
    brew install ansible
    print "Ansible installed"
  fi
}

function install_ansible_collections {
  print "Installing required Ansible Collections..."
  pushd ansible > /dev/null
  ansible-galaxy collection install -r requirements.yml
  popd > /dev/null
  print "Finished installing Ansible Collections"
}

function run_ansible {
  # Run the ansible playbook to install software
  # The playbook is designed to be idempotent where reasonable
  print "Running Ansible..."
  pushd ansible > /dev/null
  ansible-playbook macbook.yml
  popd > /dev/null
  print "Finished Running Ansible"
}

function main {
  print "Starting Setup..."
  install_homebrew
  install_python
  install_ansible
  install_ansible_collections
  run_ansible
  print "Setup Complete"
}

main