terraform {
  backend "azurerm" {
    resource_group_name  = "aks-cluster-jb-tfstate-rg"
    storage_account_name = "aksjbtfstatesa"
    container_name       = "tfstate"
    key                  = "aks-terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.72.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

//Networking Data 
data "azurerm_resource_group" "aks_vnet_rg"{
  name = "${local.naming_prefix}-network-rg"
}

data "azurerm_virtual_network" "aks_vnet" {
  name                = "${local.naming_prefix}-vnet"
  resource_group_name = data.azurerm_resource_group.aks_vnet_rg.name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = "aks"
  virtual_network_name = data.azurerm_virtual_network.aks_vnet.name
  resource_group_name  = data.azurerm_resource_group.aks_vnet_rg.name
}

data "azurerm_subnet" "appgw_subnet" {
  name                 = "appgw"
  virtual_network_name = data.azurerm_virtual_network.aks_vnet.name
  resource_group_name  = data.azurerm_resource_group.aks_vnet_rg.name
}

// Log Analytics Data
data "azurerm_resource_group" "la_rg"{
  name = "${local.naming_prefix}-la-rg"
}

data "azurerm_log_analytics_workspace" "workspace" {
  name                = "${local.naming_prefix}-la"
  resource_group_name = data.azurerm_resource_group.la_rg.name
}

//????
# data "azurerm_resource_group" "node_resource_group" {
#   name = azurerm_kubernetes_cluster.k8s.node_resource_group
#   depends_on = [
#     azurerm_kubernetes_cluster.k8s
#   ]
# }

// ACR Data
data "azurerm_resource_group" "acr_rg"{
  name = "${local.naming_prefix}-acr-rg"
}

data "azurerm_container_registry" "acr_registry" {
  name                = "${local.acr_naming_prefix}acr"
  resource_group_name = data.azurerm_resource_group.acr_rg.name
}

// Azure AD Data
data "azuread_group" "aks_admin_group" {
  display_name     = var.aks_admin_group_name
  security_enabled = true
}