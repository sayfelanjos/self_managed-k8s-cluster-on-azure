#!/usr/bin/env bash

# Exit on any error
set -e

# Update packages and install Ansible
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ansible

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i /var/tmp/ansible/inventories/hosts/hosts.ini \
  --connection=local  \
  /var/tmp/ansible/config_base_node_image.yaml
