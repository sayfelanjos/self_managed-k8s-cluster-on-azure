# Create a Standard SKU Public IP for the NAT Gateway
resource "azurerm_public_ip" "nat_gateway_ip" {
  name                = "nat-gateway-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard" # NAT Gateway requires a Standard SKU
  zones               = [1]
}

# Create the NAT Gateway resource itself
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "nat-gateway"
  resource_group_name     = var.resource_group_name
  location                = var.location
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10

  depends_on = [azurerm_public_ip.nat_gateway_ip]
}

# Associate the Public IP with the NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_gateway_ip.id
}

# Associate the NAT Gateway with your Kubernetes Subnet
# This tells the subnet to use the NAT Gateway for all outbound traffic.
resource "azurerm_subnet_nat_gateway_association" "control_planes_subnet_association" {
  subnet_id      = azurerm_subnet.control_planes_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}

resource "azurerm_subnet_nat_gateway_association" "worker_nodes_subnet_association" {
  subnet_id      = azurerm_subnet.worker_nodes_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}