resource "azurerm_role_assignment" "node_infrastructure_update_scale_set" {
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  scope                = azurerm_resource_group.aks_resource_group.id
  role_definition_name = "Virtual Machine Contributor"
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
  //scope                = azurerm_resource_group.aks_resource_group.id
  scope                = data.azurerm_container_registry.acr_registry.id
  role_definition_name = "acrpull"
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}