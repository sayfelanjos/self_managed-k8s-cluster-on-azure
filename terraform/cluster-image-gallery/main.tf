resource "azurerm_resource_group" "cluster_image_gallery_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_shared_image_gallery" "cluster_image_gallery" {
  name                = "cluster-image-gallery"
  resource_group_name = azurerm_resource_group.cluster_image_gallery_rg.name
  location            = azurerm_resource_group.cluster_image_gallery_rg.location
  description         = "Gallery for Kubernetes node images"

  tags = {
    environment = "development"
  }
}

resource "azurerm_shared_image" "base_node_image" {
  name = "ubuntu-jammy-base-node-image"
  gallery_name        = azurerm_shared_image_gallery.cluster_image_gallery.name
  resource_group_name = azurerm_resource_group.cluster_image_gallery_rg.name
  location            = azurerm_resource_group.cluster_image_gallery_rg.location
  os_type             = "Linux"
  hyper_v_generation  = "V2"

  identifier {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
  }

}