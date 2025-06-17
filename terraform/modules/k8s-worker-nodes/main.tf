resource "azurerm_linux_virtual_machine_scale_set" "k8s_master_nodes" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vmss_sku
  instances = var.vmss_instance_count
  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  source_image_reference {
    offer     = var.source_image_offer
    publisher = var.source_image_publisher
    sku       = var.source_image_sku
    version   = var.source_image_version
  }
  os_disk {
      caching                   = var.os_disk_caching
      storage_account_type      = var.os_disk_storage_account_type
      write_accelerator_enabled = true
  }
  network_interface {
      name    = "k8s-master-nodes-nic"
      primary = true

      ip_configuration {
      name      = "k8s-master-nodes-ipconfig"
      subnet_id = var.public_subnet_id
      primary   = true
      }
  }
}