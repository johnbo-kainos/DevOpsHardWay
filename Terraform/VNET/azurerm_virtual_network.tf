resource "azurerm_virtual_network" "virtual_network" {
  name =  "${local.naming_prefix}-vnet"
  location = var.location
  resource_group_name = azurerm_resource_group.vnet_resource_group.name
  address_space = [var.network_address_space]
}