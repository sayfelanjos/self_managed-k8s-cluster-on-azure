resource_group_name    = "self-managed-k8s-cluster-rg"
admin_username         = "azureadmin"
source_image_sku       = "cvm"
source_image_publisher = "Canonical"
source_image_offer     = "ubuntu-24_04-lts"
source_image_version   = "latest"

# The worker and master node names can't have numbers in their names, as Azure will append
# a sequential number in the final of the name automatically, and this number will be used by the
# scripts that will run into the VMs.
worker_nodes_name = "workernode"
master_nodes_name = "masternode"

vmss_sku                        = "Standard_D4s_v4"
vmss_instance_count             = 1
os_disk_storage_account_type    = "Standard_LRS"
os_disk_caching                 = "ReadWrite"
vnet_name                       = "self-managed-k8s-vnet"
vnet_address_space              = ["10.20.0.0/16"]
public_subnet_name              = "public-subnet"
private_subnet_name             = "private-subnet"
public_subnet_address_prefixes  = ["10.20.0.0/24"]
private_subnet_address_prefixes = ["10.20.1.0/24"]