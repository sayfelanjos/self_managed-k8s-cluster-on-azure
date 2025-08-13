# data "azurerm_image" "k8s_node_image" {
#   name                = "k8s-master-image-1.28.2"
#   resource_group_name = var.resource_group_name
# }

resource "azurerm_linux_virtual_machine_scale_set" "k8s_worker_nodes" {
  name                         = var.worker_nodes_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  sku                          = var.vmss_sku
  instances                    = var.vmss_instance_count
  admin_username               = var.admin_username
  vtpm_enabled                 = false
  secure_boot_enabled          = false
  overprovision                = false
  extension_operations_enabled = true
  single_placement_group       = false

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

  source_image_reference {
    offer     = var.source_image_offer
    publisher = var.source_image_publisher
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  # source_image_id = data.azurerm_image.k8s_node_image.id

  os_disk {
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_storage_account_type
    write_accelerator_enabled = false
  }

  network_interface {
    name    = "k8s-worker-nodes-nic"
    primary = true

    ip_configuration {
      name                                   = "k8s-worker-nodes-ipconfig"
      subnet_id                              = var.worker_nodes_subnet_id
      primary                                = true
      load_balancer_backend_address_pool_ids = [var.lb_worker_address_pool_id]
    }
  }

  custom_data = base64encode(templatefile("${path.module}/run_ansible.sh", {
    control_plane_endpoint = var.control_plane_endpoint
  }))
}