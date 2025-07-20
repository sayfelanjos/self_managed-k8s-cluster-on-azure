# This Terraform configuration creates an Azure Key Vault with access policies
# for both the user deploying the configuration and the Managed Identity of a Virtual Machine.

# Azure Provider Configuration
data "azurerm_client_config" "current" {}


# Create a random string to be appended to the Key Vault name to ensure uniqueness.
resource "random_string" "kv_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create the Azure Key Vault.
resource "azurerm_key_vault" "kv" {
  name                        = "k8s-cluster-kv-${random_string.kv_suffix.result}"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  # Access policy for the user deploying the Terraform configuration.
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Get"]
    secret_permissions = ["Get", "List", "Set", "Delete", "Purge", "Recover"]
    certificate_permissions = ["Get"]
  }

  # Add this new access policy for the Master Node
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id

    # Reference the output from the k8s-cluster module
    object_id = module.k8s-cluster.control_plane_principal_id

    # Permissions needed by the master node to store the join token
    secret_permissions = [
      "Set"
    ]
  }

    # Add this new access policy for the Worker Node
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id

    # Reference the output from the k8s-cluster module
    object_id = module.k8s-cluster.worker_node_principal_id

    # Permissions needed by the master node to store the join token
    secret_permissions = [
      "Get"
    ]
  }

  tags = var.tags
}