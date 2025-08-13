resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = var.tags
}

resource "azurerm_subnet" "worker_nodes_subnet" {
  name                 = var.worker_nodes_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.worker_nodes_subnet_address_prefixes
}

resource "azurerm_subnet" "control_planes_subnet" {
  name                                          = var.control_planes_subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = var.control_planes_subnet_address_prefixes
  default_outbound_access_enabled               = true
  private_endpoint_network_policies             = "NetworkSecurityGroupEnabled"
  private_link_service_network_policies_enabled = false
}