#!/usr/bin/env bash

# Exit on any error
set -e

# Switch to the ansible_user user to run the rest of the script
sudo -u "${ansible_user}" bash <<'EOF'

# Exit on any error
set -e

# Create a virtual environment for Ansible
python3 -m venv "$HOME/.ansible"

# Activate the virtual environment
source "$HOME/.ansible/bin/activate"

# Upgrade pip to the latest version
pip install --upgrade pip

# Install Ansible core
pip install ansible-core=="${ansible_core_version}"

# Install the Azure collection
ansible-galaxy collection install azure.azcollection

# Install Python dependencies
pip install -r "$HOME/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt"

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i /var/tmp/ansible/inventories/hosts/hosts.ini \
  --connection=local \
  --extra-var "ansible_python_interpreter=$(which python3)" \
  --extra-vars resource_group_name=${resource_group_name} \
  --extra-vars kv_name=${kv_name} \
  --extra-vars subscription_id=${subscription_id} \
  --extra-vars uai_client_id=${uai_client_id} \
  /var/tmp/ansible/setup_worker_node.yaml

EOF