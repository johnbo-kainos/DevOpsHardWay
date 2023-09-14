resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${local.naming_prefix}-aks"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  dns_prefix          = "${local.naming_prefix}-dns"
  kubernetes_version  = var.kubernetes_version

  node_resource_group = "${local.naming_prefix}-node-rg"

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = tls_private_key.rsa_4096_aks.public_key_openssh
    }
  }

  default_node_pool {
    name                 = "agentpool"
    node_count           = var.agent_count
    vm_size              = var.vm_size
    vnet_subnet_id       = data.azurerm_subnet.akssubnet.id
    type                 = "VirtualMachineScaleSets"
    orchestrator_version = var.kubernetes_version
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {
    oms_agent {
      enabled                    = var.addons.oms_agent
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.workspace.id
    }

    ingress_application_gateway {
      enabled   = var.addons.ingress_application_gateway
      subnet_id = data.azurerm_subnet.appgwsubnet.id
    }

  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
  }

  role_based_access_control {
    enabled = var.kubernetes_cluster_rbac_enabled

    azure_active_directory {
      managed                = true
      admin_group_object_ids = [var.aks_admins_group_object_id]
    }
  }

}