resource "azurerm_user_assigned_identity" "master_identity" {
  name                = "master-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_user_assigned_identity" "worker_identity" {
  name                = "worker-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}


