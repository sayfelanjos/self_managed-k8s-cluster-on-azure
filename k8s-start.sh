#!/usr/bin/env bash

# Create the Image Gallery and Base Image Definition
terraform -chdir=./terraform/cluster-image-gallery apply -auto-approve &&

# Create the custom image using Packer
packer build -var-file=packer/k8s-base-node-image/packer.pkrvars.hcl packer/k8s-base-node-image &&

# Create the resources for the Kubernetes Cluster
terraform -chdir=./terraform/cluster apply -auto-approve

# Copy the kubeconfig file from the control plane node to the local machine
scp -P 50000  azureadmin@"$(terraform -chdir=terraform/cluster output -raw master_public_ip)":/home/azureadmin/.kube/config ~/.kube/config