module "vnet" {
  source = "../modules/k8s-network"
  address_space = var.vnet_address_space
  internal_subnet_address_prefixes = var.internal_subnet_address_prefixes
  location = var.location
  resource_group_name = var.resource_group_name
  tags = var.tags
  vnet_name = var.vnet_name
}