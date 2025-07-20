resource "azurerm_virtual_machine_scale_set_extension" "network_watcher_extension" {
  name                         = "AzureNetworkWatcherAgentForLinux"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_worker_nodes.id
  publisher                    = "Microsoft.Azure.NetworkWatcher"
  type                         = "NetworkWatcherAgentLinux" # or "NetworkWatcherAgentWindows"
  type_handler_version         = "1.4"
  auto_upgrade_minor_version   = true
}

resource "azurerm_virtual_machine_scale_set_extension" "setup_k8s_worker_nodes" {
  name                         = "setup-k8s-worker-nodes"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_worker_nodes.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  auto_upgrade_minor_version   = true

  protected_settings = <<PROTECTED_SETTINGS
    {
      "script": "${base64encode(file("${path.module}/run_ansible.sh"))}"
    }
PROTECTED_SETTINGS
}