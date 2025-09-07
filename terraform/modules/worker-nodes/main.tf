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
    type         = "SystemAssigned, UserAssigned"
    identity_ids = [var.worker_nodes_user_assigned_identity_id]
  }

  source_image_id = var.k8s_base_node_image_id

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

  custom_data = base64encode(templatefile("${path.module}/worker-node-init.sh", {
    ansible_core_version = var.ansible_core_version
    resource_group_name  = var.resource_group_name
    subscription_id      = var.subscription_id
    uai_client_id        = var.worker_nodes_user_assigned_identity_client_id
    ansible_user         = var.admin_username
    kv_name              = var.kv_name
  }))
}