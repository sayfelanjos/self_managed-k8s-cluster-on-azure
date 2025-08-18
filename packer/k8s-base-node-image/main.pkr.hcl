source "azure-arm" "k8s-base-node-image" {
  # Use a managed identity for authentication to Azure
  use_azure_cli_auth = true

  os_type                           = "Linux"
  image_publisher                   = "Canonical"
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_sku                         = "22_04-lts-gen2"
  location                          = "East US"
  vm_size                           = "Standard_D2s_v4"

  shared_image_gallery_destination {
    resource_group  = "k8s-image-gallery-rg"
    gallery_name    = "k8simagegallery"
    image_name      = "k8s-base-node-image"
    image_version   = "1.0.0"
    replication_regions = ["East US"]
  }

}

build {
  sources = ["source.azure-arm.k8s-base-node-image"]

  provisioner "file" {
    source = "ansible"
    destination = "/var/tmp"
  }

  provisioner "shell" {
    script = "scripts/k8s-base-node-config.sh"
    environment_vars = []
  }
}