resource "azurerm_network_security_group" "control_planes_subnet_nsg" {
  name                = "control-planes-subnet-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "control_planes_subnet_nsg_allow_ssh" {
  name                        = "Allow-SSH"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.control_planes_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "control_planes_subnet_nsg_allow_kubernetes_api" {
  name                        = "Allow-Kubernetes-API"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.control_planes_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "control_planes_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.control_planes_subnet.id
  network_security_group_id = azurerm_network_security_group.control_planes_subnet_nsg.id
}