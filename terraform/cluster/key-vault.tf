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
  name                       = "cluster-kv-${random_string.kv_suffix.result}"
  resource_group_name        = azurerm_resource_group.k8s_cluster_rg.name
  location                   = azurerm_resource_group.k8s_cluster_rg.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  enable_rbac_authorization  = true
}