module "k8s-control-plane" {
  source         = "../k8s-control-plane"
  admin_username = var.admin_username
  admin_ssh_key  = var.admin_ssh_key
  location = var.location
  resource_group_name    = var.resource_group_name
  source_image_offer     = var.source_image_offer
  source_image_publisher = var.source_image_publisher
  source_image_sku       = var.source_image_sku
  source_image_version   = var.source_image_version
  vmss_instance_count    = var.vmss_instance_count
  vmss_name              = var.vmss_name
  vmss_sku               = var.vmss_sku
  public_subnet_id       = var.public_subnet_id
  os_disk_caching        = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
}

module "k8s-worker-nodes" {
  source         = "../k8s-worker-nodes"
  admin_username = var.admin_username
  admin_ssh_key  = var.admin_ssh_key
  location = var.location
  resource_group_name    = var.resource_group_name
  source_image_offer     = var.source_image_offer
  source_image_publisher = var.source_image_publisher
  source_image_sku       = var.source_image_sku
  source_image_version   = var.source_image_version
  vmss_instance_count = var.vmss_instance_count
  vmss_name           = var.vmss_name
  vmss_sku            = var.vmss_sku
  public_subnet_id       = var.public_subnet_id
  os_disk_caching        = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
}

module "vnet" {
  source                         = "../k8s-network"
  vnet_name                      = var.vnet_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  vnet_address_space             = var.vnet_address_space
  subnet_name                    = var.subnet_name
  public_subnet_address_prefixes = var.public_subnet_address_prefixes
  tags                           = var.tags
}