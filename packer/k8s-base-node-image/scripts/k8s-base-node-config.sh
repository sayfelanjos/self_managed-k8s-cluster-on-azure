#!/usr/bin/env bash

# Exit on any error
set -e

# Update packages and install Ansible
sudo apt-get update

# Install Pip package manager for Python
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip python3-venv

# Create a virtual environment for Ansible
python3 -m venv "$HOME"/.ansible

# Activate the virtual environment
source "$HOME"/.ansible/bin/activate

# Upgrade pip to the latest version
pip install --upgrade pip

# Install Ansible
pip install ansible-core=="${ANSIBLE_CORE_VERSION}"

# Install community.general collection
ansible-galaxy collection install community.general

# Install ansible.posix collection
ansible-galaxy collection install ansible.posix

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i /var/tmp/ansible/inventories/hosts/hosts.ini \
  --extra-var "ansible_python_interpreter=$(which python3)" \
  --connection=local  \
  /var/tmp/ansible/config_base_node_image.yaml