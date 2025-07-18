resource "azurerm_virtual_machine_scale_set_extension" "nw_extension" {
  name                         = "AzureNetworkWatcherAgentForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.id
  publisher                    = "Microsoft.Azure.NetworkWatcher"
  type                         = "NetworkWatcherAgentLinux" # or "NetworkWatcherAgentWindows"
  type_handler_version         = "1.4"
  auto_upgrade_minor_version   = true
}