resource "azurerm_virtual_machine_scale_set_extension" "nw_extension" {
  name                         = "AzureNetworkWatcherAgentForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.id
  publisher                    = "Microsoft.Azure.NetworkWatcher"
  type                         = "NetworkWatcherAgentLinux" # or "NetworkWatcherAgentWindows"
  type_handler_version         = "1.4"
  auto_upgrade_minor_version   = true
}

resource "azurerm_virtual_machine_scale_set_extension" "setup_k8s_master_nodes" {
  name                         = "setup-k8s-master-nodes"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  auto_upgrade_minor_version   = true

  protected_settings = jsonencode({
    script = base64encode(templatefile("${path.module}/run_ansible.sh.tpl", {
        control_plane_endpoint = var.master_public_ip,
    }))
  })
}