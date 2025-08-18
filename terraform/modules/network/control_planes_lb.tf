# Create a Public IP for the Load Balancer
resource "azurerm_public_ip" "control_planes_lb_pip" {
  name                = "control-planes-lb-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create the Load Balancer itself
resource "azurerm_lb" "control_planes_lb" {
  name                = "control-planes-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = azurerm_public_ip.control_planes_lb_pip.name
    public_ip_address_id = azurerm_public_ip.control_planes_lb_pip.id
  }
}

# Create the Backend Address Pool
resource "azurerm_lb_backend_address_pool" "control_planes_bkeapool" {
  name            = "control-planes-backend-pool"
  loadbalancer_id = azurerm_lb.control_planes_lb.id
}

# resource "azurerm_lb_backend_address_pool_address" "control_planes_node_1_ip" {
#   name                    = "control-planes-node-1-ip"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.control_planes_bkeapool.id
#   virtual_network_id      = azurerm_virtual_network.vnet.id
#   ip_address              = "10.20.1.6" # Static IP of the first master node
# }


# Create a Health Probe for the K8s API Server
resource "azurerm_lb_probe" "control_planes_probe" {
  loadbalancer_id = azurerm_lb.control_planes_lb.id
  name            = "k8s-api-server-probe"
  port            = 6443
  request_path    = null # "/healthz" is not needed for TCP probes
  protocol        = "Tcp"
}

# Create the Load Balancing Rule
resource "azurerm_lb_rule" "control_planes_rule" {
  loadbalancer_id                = azurerm_lb.control_planes_lb.id
  name                           = "k8s-api-server-rule"
  protocol                       = "Tcp"
  frontend_port                  = 6443
  backend_port                   = 6443
  frontend_ip_configuration_name = azurerm_public_ip.control_planes_lb_pip.name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.control_planes_bkeapool.id]
  probe_id                       = azurerm_lb_probe.control_planes_probe.id
  disable_outbound_snat          = true
}

resource "azurerm_lb_nat_rule" "control_planes_nat_rule" {
  resource_group_name            = azurerm_lb.control_planes_lb.resource_group_name
  loadbalancer_id                = azurerm_lb.control_planes_lb.id
  name                           = "control-planes-nat-rule"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50050
  backend_port                   = 22
  backend_address_pool_id        = azurerm_lb_backend_address_pool.control_planes_bkeapool.id
  frontend_ip_configuration_name = azurerm_public_ip.control_planes_lb_pip.name
}