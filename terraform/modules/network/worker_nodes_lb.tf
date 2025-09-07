# Create a Public IP for the Load Balancer
resource "azurerm_public_ip" "worker_nodes_lb_pip" {
  name                = "worker-nodes-lb-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create the Load Balancer itself
resource "azurerm_lb" "worker_nodes_lb" {
  name                = "worker-nodes-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = azurerm_public_ip.worker_nodes_lb_pip.name
    public_ip_address_id = azurerm_public_ip.worker_nodes_lb_pip.id
  }
}

# Create the Backend Address Pool
resource "azurerm_lb_backend_address_pool" "worker_nodes_bkeapool" {
  name            = "worker-nodes-backend-pool"
  loadbalancer_id = azurerm_lb.worker_nodes_lb.id
}

# Create a Health Probe for the K8s API Server
resource "azurerm_lb_probe" "worker_nodes_probe" {
  loadbalancer_id = azurerm_lb.worker_nodes_lb.id
  name            = "k8s-worker-health-check-probe"
  port            = 10254
  protocol        = "Tcp"
}

# Create the Load Balancing Rule
resource "azurerm_lb_rule" "worker_nodes_rule" {
  loadbalancer_id                = azurerm_lb.worker_nodes_lb.id
  name                           = "k8s-http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_public_ip.worker_nodes_lb_pip.name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.worker_nodes_bkeapool.id]
  probe_id                       = azurerm_lb_probe.worker_nodes_probe.id
  disable_outbound_snat          = true
}

resource "azurerm_lb_nat_rule" "worker_nodes_nat_rule" {
  resource_group_name            = azurerm_lb.worker_nodes_lb.resource_group_name
  loadbalancer_id                = azurerm_lb.worker_nodes_lb.id
  name                           = "worker-nodes-nat-rule"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50050
  backend_port                   = 22
  backend_address_pool_id        = azurerm_lb_backend_address_pool.worker_nodes_bkeapool.id
  frontend_ip_configuration_name = azurerm_public_ip.worker_nodes_lb_pip.name
}