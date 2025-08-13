module "k8s-cluster" {
  source                          = "../modules/k8s-cluster"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  control_planes_name               = var.control_planes_name
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
  control_planes_subnet_name             = var.control_planes_subnet_name
  control_planes_subnet_address_prefixes = var.control_planes_subnet_address_prefixes
  control_planes_subnet_id               = module.k8s-cluster.control_planes_subnet_id
  worker_nodes_subnet_name              = var.worker_nodes_subnet_name
  worker_nodes_subnet_address_prefixes  = var.worker_nodes_subnet_address_prefixes
  worker_nodes_subnet_id                = module.k8s-cluster.worker_nodes_subnet_id
  os_disk_caching                 = var.os_disk_caching
  os_disk_storage_account_type    = var.os_disk_storage_account_type
  pod_network_cidr                = var.pod_network_cidr
  # kv_uri                          = azurerm_key_vault.kv.vault_uri
}