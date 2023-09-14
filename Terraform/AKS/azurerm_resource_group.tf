resource "azurerm_resource_group" "aks_resource_group" {
  name     = "${local.naming_prefix}-rg"
  location = var.location
}
