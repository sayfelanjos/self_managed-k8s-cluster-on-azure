resource "azurerm_linux_virtual_machine_scale_set" "k8s_master_nodes" {
  name                         = var.control_planes_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  sku                          = var.vmss_sku
  instances                    = var.vmss_instance_count
  admin_username               = var.admin_username
  vtpm_enabled                 = false
  secure_boot_enabled          = false
  extension_operations_enabled = true
  overprovision                = false

  boot_diagnostics {
    storage_account_uri = null
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  identity {
    type = "SystemAssigned"
  }

  source_image_id = var.k8s_base_node_image_id

  os_disk {
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_storage_account_type
    write_accelerator_enabled = false
  }

  network_interface {
    name    = "k8s-control-plane-nodes-nic"
    primary = true
    # network_security_group_id = var.master_nodes_nsg_id

    ip_configuration {
      name                                   = "k8s-control-plane-nodes-ipconfig"
      subnet_id                              = var.control_planes_subnet_id
      primary                                = true
      load_balancer_backend_address_pool_ids = [var.lb_master_address_pool_id]
    }
  }

  custom_data = base64encode(templatefile("${path.module}/control-plane-init.sh", {
    control_plane_endpoint = var.control_plane_endpoint
    pod_network_cidr       = var.pod_network_cidr
    kv_uri                 = var.kv_uri
  }))
}
