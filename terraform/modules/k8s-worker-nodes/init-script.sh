#!/bin/bash
echo "Starting VMSS initialization..." >> /var/log/vmss-init.log

# Update system
apt-get update
apt-get upgrade -y

# Install required packages
apt-get install -y curl wget git

# Custom initialization logic here
echo "VMSS initialization completed" >> /var/log/vmss-init.log