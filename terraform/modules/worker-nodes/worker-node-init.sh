#!/usr/bin/env bash

# Exit on any error
set -e

# Update packages and install Ansible
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ansible

# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Clone your git repository
# Make sure your repository is accessible from the VM.
# For private repos, you might need to handle credentials.
# rm -rf /tmp/worker-node-setup
# git clone --depth 1 --filter=blob:none https://github.com/sayfelanjos/self_managed-k8s-cluster-on-azure /tmp/worker-node-setup
# cd /tmp/worker-node-setup
# git sparse-checkout init --no-cone
# git sparse-checkout set ansible

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i /root/ansible/inventories/hosts/hosts.ini \
  --connection=local \
  --extra-vars pod_network_cidr=${pod_network_cidr} \
  --extra-vars control_plane_endpoint=${control_plane_endpoint} \
  --extra-vars kv_uri=${kv_uri} \
  /root/ansible/setup_worker_node.yaml