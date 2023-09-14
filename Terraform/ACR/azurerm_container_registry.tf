resource "azurerm_container_registry" "acr" {
  name                = "${local.naming_prefix}-acr"
  resource_group_name = azurerm_resource_group.acr_resource_group.name
  location            = azurerm_resource_group.acr_resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
}