resource "azurerm_user_assigned_identity" "control_plane_uai" {
  name                = "control-plane-user-assigned-identity"
  resource_group_name = azurerm_resource_group.k8s_cluster_rg.name
  location            = azurerm_resource_group.k8s_cluster_rg.location
}

# Grant the UAI permission to write secrets to the Key Vault
resource "azurerm_role_assignment" "uai_kv_secrets_officer" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_user_assigned_identity.control_plane_uai.principal_id
}


resource "azurerm_user_assigned_identity" "worker_node_uai" {
  name                = "worker-node-user-assigned-identity"
  resource_group_name = azurerm_resource_group.k8s_cluster_rg.name
  location            = azurerm_resource_group.k8s_cluster_rg.location
}

# Grant the UAI permission to read secrets to the Key Vault
resource "azurerm_role_assignment" "uai_kv_secrets_user" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.worker_node_uai.principal_id
}

# Grant the UAI permission to read metadata to the Key Vault
resource "azurerm_role_assignment" "uai_kv_secrets_reader" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_user_assigned_identity.worker_node_uai.principal_id
}