# # resource "azurerm_virtual_machine_scale_set_extension" "nw_extension" {
# #   name                         = "AzureNetworkWatcherAgentForLinux"
# #   virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.id
# #   publisher                    = "Microsoft.Azure.NetworkWatcher"
# #   type                         = "NetworkWatcherAgentLinux" # or "NetworkWatcherAgentWindows"
# #   type_handler_version         = "1.4"
# #   auto_upgrade_minor_version   = true
# #   provision_after_extensions = [azurerm_virtual_machine_scale_set_extension.setup_k8s_master_nodes.name]
# # }
#
# resource "azurerm_virtual_machine_scale_set_extension" "setup_k8s_master_nodes" {
#   name                         = "setup-k8s-master-nodes"
#   virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.id
#   publisher                    = "Microsoft.Azure.Extensions"
#   type                         = "CustomScript"
#   type_handler_version         = "2.1"
#   auto_upgrade_minor_version   = true
#
#   protected_settings = jsonencode({
#     script = base64encode(file("${path.module}/hello.sh"))
#   })
#
#   settings = jsonencode({
#     force_run = sha256(file("${path.module}/hello.sh"))
#     timeout   = "PT5M"
#     script    = base64encode(file("${path.module}/hello.sh"))
#     # commandToExecute = "sh echo $HOSTNAME"
#   })
#
#   # settings = jsonencode({
#   #   force_run = sha256(templatefile("${path.module}/hello.sh", {
#   #     ansible_version        = "2.10.7+merged+base+2.10.8+dfsg-1"
#   #     control_plane_endpoint = var.master_public_ip
#   #     kv_uri                 = var.kv_uri
#   #   }))
#   # })
# }
#
# # resource "azurerm_virtual_machine_scale_set_extension" "example" {
# #   name                         = "example"
# #   virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.k8s_master_nodes.id
# #   publisher                    = "Microsoft.Azure.Extensions"
# #   type                         = "CustomScript"
# #   type_handler_version         = "2.0"
# #   settings = jsonencode({
# #     "commandToExecute" = "echo $HOSTNAME > /tmp/hostname.txt"
# #   })
# # }