#!/usr/bin/env bash

# Exit on any error
set -e


# Update packages and install Ansible
sudo apt-get update
# update-alternatives --set iptables /usr/sbin/iptables-legacy &&
# update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy &&
# systemctl restart walinuxagent
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ansible


# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Clone your git repository
# Make sure your repository is accessible from the VM.
# For private repos, you might need to handle credentials.
# rm -rf /tmp/control-plane-setup
# git clone --depth 1 --filter=blob:none https://github.com/sayfelanjos/self_managed-k8s-cluster-on-azure /tmp/control-plane-setup
# cd /tmp/control-plane-setup
# git sparse-checkout init --no-cone
# git sparse-checkout set ansible

# Run the Ansible playbook
# The --connection=local flag tells Ansible to run on the machine itself.
ansible-playbook -i  /root/ansible/inventories/hosts/hosts.ini \
  --connection=local \
  --extra-vars pod_network_cidr=${pod_network_cidr} \
  --extra-vars control_plane_endpoint=${control_plane_endpoint} \
  --extra-vars kv_uri=${kv_uri} \
  /root/ansible/ansible/setup_control_plane.yaml
