resource "azurerm_resource_group" "k8s_cluster_rg" {
  name     = var.resource_group_name
  location = var.location
}