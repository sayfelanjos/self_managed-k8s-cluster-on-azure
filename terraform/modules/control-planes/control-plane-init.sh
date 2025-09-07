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

# Add ansible-core to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install the Azure collection
ansible-galaxy collection install azure.azcollection

# Install Python dependencies
pip install -r "$HOME/.ansible/collections/ansible_collections/azure/azcollection/requirements.txt"

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i /var/tmp/ansible/inventories/hosts/hosts.ini \
    --extra-var "ansible_python_interpreter=$(which python3)" \
    --extra-var "resource_group_name=self-managed-k8s-cluster-rg" \
    --extra-var "control_plane_endpoint=${control_plane_endpoint}" \
    --extra-var "pod_network_cidr=${pod_network_cidr}" \
    --extra-var "ansible_user=${ansible_user}" \
    --extra-var "kv_name=${kv_name}" \
    --extra-var "uai_client_id=${uai_client_id}" \
    --extra-var "subscription_id=${subscription_id}" \
    /var/tmp/ansible/setup_control_plane.yaml

EOF