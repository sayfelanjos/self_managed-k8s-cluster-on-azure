output "storage_account_name" {
  description = "The name of the storage account for Terraform state."
  value       = azurerm_storage_account.self_managed_k8s_cluster_tf_state_sa.name
}

output "resource_group_name" {
  description = "The name of the resource group for the state storage account."
  value       = azurerm_resource_group.self_managed_k8s_cluster_tf-state_rg.name
}

output "storage_container_name" {
  description = "The name of the storage container for Terraform state."
  value       = azurerm_storage_container.clusters_tf_state_container.name
}
