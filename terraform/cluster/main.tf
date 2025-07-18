resource "azurerm_resource_group" "k8s_cluster_rg" {
  name     = var.resource_group_name
  location = var.location
}

module "k8s-cluster" {
  source                          = "../modules/k8s-cluster"
  resource_group_name             = azurerm_resource_group.k8s_cluster_rg.name
  location                        = azurerm_resource_group.k8s_cluster_rg.location
  master_nodes_name               = var.master_nodes_name
  worker_nodes_name               = var.worker_nodes_name
  vmss_instance_count             = var.vmss_instance_count
  vmss_sku                        = var.vmss_sku
  source_image_offer              = var.source_image_offer
  source_image_publisher          = var.source_image_publisher
  source_image_sku                = var.source_image_sku
  source_image_version            = var.source_image_version
  admin_username                  = var.admin_username
  admin_ssh_key                   = var.admin_ssh_key
  vnet_name                       = var.vnet_name
  vnet_address_space              = var.vnet_address_space
  private_subnet_name             = var.private_subnet_name
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  private_subnet_id               = module.k8s-cluster.private_subnet_id
  public_subnet_name              = var.public_subnet_name
  public_subnet_address_prefixes  = var.public_subnet_address_prefixes
  public_subnet_id                = module.k8s-cluster.public_subnet_id
  os_disk_caching                 = var.os_disk_caching
  os_disk_storage_account_type    = var.os_disk_storage_account_type
}