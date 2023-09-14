resource "azurerm_resource_group" "acr_resource_group" {
  name     = "${local.naming_prefix}-acr-rg"
  location = var.location
}