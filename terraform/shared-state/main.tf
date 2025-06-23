resource "azurerm_resource_group" "self_managed_k8s_cluster_tf-state_rg" {
  name     = "self-managed-k8s-cluster-tf-state-rg"
  location = "EastUS"
}

resource "azurerm_storage_account" "self_managed_k8s_cluster_tf_state_sa" {
  name                     = "selfmanagedk8sstate"
  resource_group_name      = azurerm_resource_group.self_managed_k8s_cluster_tf-state_rg.name
  location                 = azurerm_resource_group.self_managed_k8s_cluster_tf-state_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "clusters_tf_state_container" {
  name                  = "self-managed-k8s-cluster-tf-state-container"
  storage_account_id    = azurerm_storage_account.self_managed_k8s_cluster_tf_state_sa.id
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.self_managed_k8s_cluster_tf_state_sa]
  lifecycle {
    prevent_destroy = true
  }
}