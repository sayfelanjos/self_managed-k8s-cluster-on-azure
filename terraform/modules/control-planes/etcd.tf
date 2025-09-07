# resource "azurerm_managed_disk" "etcd_disk" {
#   name                 = "etcd-disk"
#   resource_group_name  = var.resource_group_name
#   location             = var.location
#   storage_account_type = "Premium_LRS"
#   create_option        = "Empty"
#   disk_size_gb         = 32 # Adjust size as needed
# }