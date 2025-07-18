#!/usr/bin/env bash

# Exit on any error
set -e

# Update packages and install Ansible
sudo apt-get update
sudo apt-get install -y ansible

# Clone your git repository
# Make sure your repository is accessible from the VM.
# For private repos, you might need to handle credentials.
git clone <YOUR_GIT_REPO_URL> /tmp/k8s-cluster-setup
cd /tmp/k8s-cluster-setup

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i ansible/inventories/dev-cluster/hosts/hosts.ini --connection=local ansible/cluster.yaml