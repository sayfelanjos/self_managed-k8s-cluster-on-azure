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
  name                       = "k8s-cluster-kv-${random_string.kv_suffix.result}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  # Access policy for the user deploying the Terraform configuration.
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions         = ["Get"]
    secret_permissions      = ["Get", "List", "Set", "Delete", "Purge", "Recover"]
    certificate_permissions = ["Get"]
  }
}

resource "azurerm_key_vault_access_policy" "master_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.master_identity.client_id

  # Specify permissions for secrets
  secret_permissions = [
    "Set",
  ]
}

resource "azurerm_key_vault_access_policy" "worker_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.worker_identity.client_id

  # Specify permissions for secrets
  secret_permissions = [
    "Get",
  ]
}