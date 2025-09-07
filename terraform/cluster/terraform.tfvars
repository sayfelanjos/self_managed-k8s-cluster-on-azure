resource_group_name    = "self-managed-k8s-cluster-rg"
admin_username         = "azureadmin"
source_image_sku       = "cvm"
source_image_publisher = "Canonical"
source_image_offer     = "ubuntu-24_04-lts"
source_image_version   = "latest"
k8s_base_node_image_id = "/subscriptions/5c61423a-be60-4fbb-a575-7999e5429920/resourceGroups/k8s-image-gallery-rg/providers/Microsoft.Compute/galleries/k8simagegallery/images/k8s-base-node-image/versions/1.0.0"

# The worker and master node names can't have numbers in their names, as Azure will append
# a sequential number in the final of the name automatically, and this number will be used by the
# scripts that will run into the VMs.
worker_nodes_name                      = "workernode"
control_planes_name                    = "controlplane"
pod_network_cidr                       = "10.244.0.0/16"
vmss_sku                               = "Standard_B2s" #"Standard_D4s_v4"
vmss_instance_count                    = 2
os_disk_storage_account_type           = "Standard_LRS"
os_disk_caching                        = "ReadWrite"
vnet_name                              = "cluster-vnet"
vnet_address_space                     = ["10.20.0.0/16"]
worker_nodes_subnet_name               = "worker-nodes-subnet"
control_planes_subnet_name             = "control-planes-subnet"
worker_nodes_subnet_address_prefixes   = ["10.20.0.0/24"]
control_planes_subnet_address_prefixes = ["10.20.1.0/24"]