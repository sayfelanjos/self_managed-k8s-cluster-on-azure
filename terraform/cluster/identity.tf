resource "azurerm_user_assigned_identity" "control_plane_uai" {
  name                = "control-plane-user-assigned-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_user_assigned_identity" "worker_node_uai" {
  name                = "worker-node-user-assigned-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}


