resource "azurerm_log_analytics_workspace" "Log_Analytics_WorkSpace" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${local.naming_prefix}-logs"
    location            = var.location
    resource_group_name = azurerm_resource_group.log_resource_group.name
    sku                 = "PerGB2018"
}