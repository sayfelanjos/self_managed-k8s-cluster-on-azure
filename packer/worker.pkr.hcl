# source "azure-arm" "worker" {
#   # Assign the User-Assigned Managed Identity to the temporary Packer VM
#   identity_id               = var.worker_identity_id
#
#   # Use a managed identity for authentication to Azure
#   use_azure_cli_auth = true
#
#   os_type                           = "Linux"
#   image_publisher                   = "Canonical"
#   image_offer                       = "0001-com-ubuntu-server-jammy"
#   image_sku                         = "22_04-lts-gen2"
#   location                          = "East US"
#   vm_size                           = "Standard_DS2_v2"
#   managed_image_name                = "k8s-worker-image-1.28.2"
#   managed_image_resource_group_name = var.resource_group_name
# }
#
# build {
#   sources = ["source.azure-arm.worker"]
#
#   provisioner "shell" {
#     script = "scripts/worker-setup.sh"
#     arguments = [
#       "-resource_group_name=${var.resource_group_name}",
#       "-location=${var.location}",
#       "-client_id=${var.client_id}",
#       "-client_secret=${var.client_secret}",
#       "-tenant_id=${var.tenant_id}",
#       "-subscription_id=${var.subscription_id}",
#       "-key_vault_name=${var.key_vault_name}"
#     ]
#   }
# }