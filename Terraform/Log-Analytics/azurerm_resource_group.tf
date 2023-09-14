resource "azurerm_resource_group" "log_resource_group" {
  name     = "${local.naming_prefix}-log-rg"
  location = var.location
}