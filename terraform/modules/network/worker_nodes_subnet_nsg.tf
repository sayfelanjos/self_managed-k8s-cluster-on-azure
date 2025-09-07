resource "azurerm_network_security_group" "worker_nodes_subnet_nsg" {
  name                = "worker-nodes-subnet-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_network_security_rule" "worker_nodes_subnet_nsg_rule_allow_ssh" {
  name                        = "Allow-SSH"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.worker_nodes_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_kubernetes_nodeport" {
  name                        = "Allow-Kubernetes-NodePort"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "30000-32767"
  destination_address_prefix  = var.vnet_address_space[0]
  network_security_group_name = azurerm_network_security_group.worker_nodes_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_kubernetes_health_check_probe" {
  name                        = "Allow-Kubernetes-Health-Check-Probe"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  source_address_prefix       = "*"
  destination_port_range      = "10254"
  destination_address_prefix  = var.vnet_address_space[0]
  network_security_group_name = azurerm_network_security_group.worker_nodes_subnet_nsg.name
  resource_group_name         = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "worker_nodes_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.worker_nodes_subnet.id
  network_security_group_id = azurerm_network_security_group.worker_nodes_subnet_nsg.id
}
