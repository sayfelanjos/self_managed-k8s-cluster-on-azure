#!/usr/bin/env bash

# Exit on any error
set -e


# Update packages and install Ansible
sudo apt update
sudo apt install -y ansible


# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Clone your git repository
# Make sure your repository is accessible from the VM.
# For private repos, you might need to handle credentials.
rm -rf /tmp/k8s-master-setup
git clone --depth 1 --filter=blob:none https://github.com/sayfelanjos/self_managed-k8s-cluster-on-azure /tmp/k8s-master-setup
cd /tmp/k8s-master-setup
git sparse-checkout init --no-cone
git sparse-checkout set ansible

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i ansible/inventories/hosts/hosts.ini \
  --connection=local  \
  ansible/install_master.yaml
#  --extra-vars control_plane_endpoint="$CONTROL_PLANE_ENDPOINT" \
#  --extra-vars pod_network_cidr="$POD_NETWORK_CIDR"
