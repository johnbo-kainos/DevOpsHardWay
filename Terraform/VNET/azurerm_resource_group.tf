resource "azurerm_resource_group" "vnet_resource_group" {
  name     = "${local.naming_prefix}-network-rg"
  location = var.location
}