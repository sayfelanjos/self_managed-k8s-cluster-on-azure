module "k8s-control-plane" {
  source                       = "../control-planes"
  admin_username               = var.admin_username
  admin_ssh_key                = var.admin_ssh_key
  location                     = var.location
  resource_group_name          = var.resource_group_name
  source_image_offer           = var.source_image_offer
  source_image_publisher       = var.source_image_publisher
  source_image_sku             = var.source_image_sku
  source_image_version         = var.source_image_version
  vmss_instance_count          = var.vmss_instance_count
  control_planes_name          = var.control_planes_name
  vmss_sku                     = var.vmss_sku
  control_planes_subnet_id     = var.control_planes_subnet_id
  os_disk_caching              = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
  lb_master_address_pool_id    = module.vnet.lb_master_address_pool_id
  control_plane_endpoint       = module.vnet.control_plane_endpoint
  pod_network_cidr             = var.pod_network_cidr
  # kv_uri                       = var.kv_uri
  control_planes_subnet_nsg_id = module.vnet.control_planes_subnet_nsg_id
}

module "k8s-worker-nodes" {
  source                       = "../worker-nodes"
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
  worker_nodes_subnet_id       = var.worker_nodes_subnet_id
  os_disk_caching              = var.os_disk_caching
  os_disk_storage_account_type = var.os_disk_storage_account_type
  lb_worker_address_pool_id    = module.vnet.lb_worker_address_pool_id
  control_plane_endpoint       = module.vnet.control_plane_endpoint
  pod_network_cidr             = var.pod_network_cidr
}

module "vnet" {
  source                                 = "../network"
  vnet_name                              = var.vnet_name
  resource_group_name                    = var.resource_group_name
  location                               = var.location
  vnet_address_space                     = var.vnet_address_space
  worker_nodes_subnet_name               = var.worker_nodes_subnet_name
  control_planes_subnet_name             = var.control_planes_subnet_name
  control_planes_subnet_address_prefixes = var.control_planes_subnet_address_prefixes
  worker_nodes_subnet_address_prefixes   = var.worker_nodes_subnet_address_prefixes
  tags                                   = var.tags
  control_planes_name                    = var.control_planes_name
}