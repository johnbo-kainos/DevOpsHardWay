name     = "aks-cluster"
location = "uksouth"

kubernetes_version   = "1.27.3"
agent_count          = 3
vm_size              = "Standard_B2ms"
aks_admin_group_name = "aks-cluster-jb-group"

addons = {
  oms_agent                   = true
  ingress_application_gateway = true
}