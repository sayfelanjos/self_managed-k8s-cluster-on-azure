#!/usr/bin/env bash

# Exit on any error
set -e

# Update packages and install Ansible
sudo apt-get update

# Install Pip package manager for Python
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python3-pip python3-venv

# Install Ansible
pip install ansible-core==2.16

# Install the Azure collection
ansible-galaxy collection install azure.azcollection



# Install Python dependencies
pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt


# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i /var/tmp/ansible/inventories/hosts/hosts.ini \
  --connection=local  \
  /var/tmp/ansible/config_base_node_image.yaml
