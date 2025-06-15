resource azurerm_virtual_machine_scale_set "k8s_master_nodes" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vmss_sku
  instances           = var.vmss_instance_count
  admin_username      = var.admin_username
  upgrade_policy_mode = "Manual"

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  os_disk {
    storage_account_type = var.os_disk_storage_account_type
    caching              = var.os_disk_caching
  }

  network_interface {
    name    = "k8s-master-nodes-nic"
    primary = true

    ip_configuration {
      name      = "k8s-master-nodes-ipconfig"
      primary   = true
      subnet_id = var.subnet_id
    }
  }
}