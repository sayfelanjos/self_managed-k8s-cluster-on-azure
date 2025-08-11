resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "log-analytics-workspace"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 7
}