resource "azurerm_resource_group" "self_managed_k8s_cluster_rg" {
  name     = "self-managed-k8s-cluster-rg"
  location = "eastus2"
}