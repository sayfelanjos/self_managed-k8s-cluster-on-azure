output "control_plane_principal_id" {
  description = "The Principal ID of the System Assigned Managed Identity for the Control Plane."
  # Note: The resource name "control_plane" must match what you have in main.tf
  # The [0] is needed because the identity block is technically a list.
  value = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.identity[0].principal_id
}
