# Create a Public IP for the Load Balancer
resource "azurerm_public_ip" "k8s_worker_lb_pip" {
  name                = "k8s-worker-lb-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Create the Load Balancer itself
resource "azurerm_lb" "k8s_worker_lb" {
  name                = "k8s-worker-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.k8s_worker_lb_pip.id
  }
}

# Create the Backend Address Pool
resource "azurerm_lb_backend_address_pool" "k8s_worker_bkeapool" {
  name            = "k8s-worker-backend-pool"
  loadbalancer_id = azurerm_lb.k8s_worker_lb.id
}

# Create a Health Probe for the K8s API Server
resource "azurerm_lb_probe" "k8s_worker_probe" {
  loadbalancer_id = azurerm_lb.k8s_worker_lb.id
  name            = "k8s-api-server-probe"
  port            = 6443
  protocol        = "Tcp"
}

# Create the Load Balancing Rule
resource "azurerm_lb_rule" "k8s_worker_rule" {
  loadbalancer_id                = azurerm_lb.k8s_worker_lb.id
  name                           = "k8s-api-server-rule"
  protocol                       = "Tcp"
  frontend_port                  = 6443
  backend_port                   = 6443
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.k8s_worker_bkeapool.id]
  probe_id                       = azurerm_lb_probe.k8s_worker_probe.id
}

