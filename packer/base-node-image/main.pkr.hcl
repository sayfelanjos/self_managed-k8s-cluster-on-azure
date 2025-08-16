source "azure-arm" "master" {
  # Use a managed identity for authentication to Azure
  use_azure_cli_auth = true

  # Assign the User-Assigned Managed Identity to the temporary Packer VM
  # client_id = var.master_identity_id


  os_type                           = "Linux"
  image_publisher                   = "Canonical"
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_sku                         = "22_04-lts-gen2"
  location                          = "East US"
  vm_size                           = "Standard_D4s_v4"

  shared_image_gallery_destination {
    resource_group  = "cluster-image-gallery-rg"
    gallery_name    = "cluster-image-gallery"
    image_name      = "ubuntu-jammy-base-node-image"
    image_version   = "1.0.0"
    replication_regions = ["East US"]
  }

}

build {
  sources = ["source.azure-arm.master"]

  provisioner "shell" {
    script = "scripts/master-setup.sh"
    environment_vars = [
      "ANSIBLE_VERSION=${var.ansible_version}",
      "CONTROL_PLANE_ENDPOINT=${var.control_plane_endpoint}",
      "POD_NETWORK_CIDR=${var.pod_network_cidr}",
      # "KV_URI=${var.kv_uri}",
      # "RESOURCE_GROUP_NAME=${var.resource_group_name}",
      # "LOCATION=${var.location}",
      # "CLIENT_ID=${var.client_id}"
    ]
  }

}