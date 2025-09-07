#!/usr/bin/env bash

# Delete the image version from the Image Gallery
az sig image-version delete --gallery-image-name k8s-base-node-image --gallery-image-version 1.0.0 --gallery-name k8simagegallery --resource-group k8s-image-gallery-rg --subscription "${ARM_SUBSCRIPTION_ID}" &&

# Destroy the image gallery and Image Definition
terraform -chdir=./terraform/cluster-image-gallery destroy -auto-approve &&

# Destroy the resources created for the Kubernetes Cluster
terraform -chdir=./terraform/cluster destroy -auto-approve