resource "azurerm_network_security_group" "private_subnet_nsg" {
  name                = "private-subnet-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "Allow-SSH"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.private_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_kubernetes_api" {
  name                        = "Allow-Kubernetes-API"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "6443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.private_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "private_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.k8s_private_subnet.id
  network_security_group_id = azurerm_network_security_group.private_subnet_nsg.id
}