terraform {
  backend "azurerm" {
    resource_group_name  = "aks-cluster-jb-tfstate-rg"
    storage_account_name = "aksjbtfstatesa"
    container_name       = "tfstate"
    key                  = "aks-terraform.tfstate"
  }
}

provider "azurerm" {
  version = "~> 2.0"
  features {}
}

data "azurerm_resource_group" "resource_group" {
  name = "jb-${var.name}-rg"
}

data "azurerm_subnet" "akssubnet" {
  name                 = "aks"
  virtual_network_name = "jb-${var.name}-vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}

data "azurerm_subnet" "appgwsubnet" {
  name                 = "appgw"
  virtual_network_name = "jb-${var.name}-vnet"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
}

data "azurerm_log_analytics_workspace" "workspace" {
  name                = "jb-${var.name}-la"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

data "azurerm_resource_group" "node_resource_group" {
  name = azurerm_kubernetes_cluster.k8s.node_resource_group
  depends_on = [
    azurerm_kubernetes_cluster.k8s
  ]
}



data "azurerm_container_registry" "example" {
  name                = "jb${var.name}acr"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

