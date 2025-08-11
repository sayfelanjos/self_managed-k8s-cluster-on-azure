source "azure-arm" "master" {
  # Use a managed identity for authentication to Azure
  use_azure_cli_auth = true

  # Assign the User-Assigned Managed Identity to the temporary Packer VM
  identity_id = var.master_identity_id


  os_type                           = "Linux"
  image_publisher                   = "Canonical"
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_sku                         = "22_04-lts-gen2"
  location                          = "East US"
  vm_size                           = "Standard_D4s_v4"
  managed_image_name                = "k8s-master-image-1.28.2"
  managed_image_resource_group_name = "k8s-cluster-images-rg"
}

build {
  sources = ["source.azure-arm.master"]

  provisioner "shell" {
    script = "scripts/master-setup.sh"
    environment = [
      "$ANSIBLE_VERSION=${var.ansible_version}",
      "CONTROL_PLANE_ENDPOINT=${var.control_plane_endpoint}",
      "POD_NETWORK_CIDR=${var.pod_network_cidr}",
      # "KV_URI=${var.kv_uri}",
      # "RESOURCE_GROUP_NAME=${var.resource_group_name}",
      # "LOCATION=${var.location}",
      # "CLIENT_ID=${var.client_id}"
    ]
  }
}