module "k8s-control-plane" {
  source                       = "../k8s-control-plane"
  admin_username               = var.admin_username
  admin_ssh_key                = var.admin_ssh_key
  location                     = var.location
  resource_group_name          = var.resource_group_name
  source_image_offer           = var.source_image_offer
  source_image_publisher       = var.source_image_publisher
  source_image_sku             = var.source_image_sku
  source_image_version         = var.source_image_version
  vmss_instance_count          = var.vmss_instance_count
  master_nodes_name            = var.master_nodes_name
  vmss_sku                     = var.vmss_sku
  private_subnet_id            = var.private_subnet_id
  os_disk_caching              = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
  lb_master_address_pool_id    = module.vnet.lb_master_address_pool_id
  master_public_ip             = module.vnet.master_public_ip
}

module "k8s-worker-nodes" {
  source                       = "../k8s-worker-nodes"
  admin_username               = var.admin_username
  admin_ssh_key                = var.admin_ssh_key
  location                     = var.location
  resource_group_name          = var.resource_group_name
  source_image_offer           = var.source_image_offer
  source_image_publisher       = var.source_image_publisher
  source_image_sku             = var.source_image_sku
  source_image_version         = var.source_image_version
  vmss_instance_count          = var.vmss_instance_count
  worker_nodes_name            = var.worker_nodes_name
  vmss_sku                     = var.vmss_sku
  private_subnet_id             = var.private_subnet_id
  os_disk_caching              = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
  lb_worker_address_pool_id    = module.vnet.lb_worker_address_pool_id
}

module "vnet" {
  source                         = "../k8s-network"
  vnet_name                      = var.vnet_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  vnet_address_space             = var.vnet_address_space
  public_subnet_name                    = var.public_subnet_name
  private_subnet_name                    = var.private_subnet_name
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  public_subnet_address_prefixes = var.public_subnet_address_prefixes
  tags                           = var.tags
}