resource "azurerm_lb" "k8s_cluster_lb" {
  name                = "k8s-external-lb"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.k8s_cluster_public_ip.id
  }
}

resource "azurerm_public_ip" "k8s_cluster_public_ip" {
  name                = "k8s-cluster-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
}