resource "azurerm_log_analytics_solution" "Log_Analytics_Solution_ContainerInsights" {
  solution_name         = "ContainerInsights"
  location              = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.location
  resource_group_name   = azurerm_resource_group.log_resource_group.name
  workspace_resource_id = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.id
  workspace_name        = azurerm_log_analytics_workspace.Log_Analytics_WorkSpace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}