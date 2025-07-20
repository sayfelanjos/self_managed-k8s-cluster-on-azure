output "worker_node_principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity for the Worker Node."
  # Note: The resource name "worker_node" must match what you have in main.tf
  # The [0] is needed because the identity block is technically a list.
  value       = azurerm_linux_virtual_machine_scale_set.k8s_worker_nodes.identity[0].principal_id
}
