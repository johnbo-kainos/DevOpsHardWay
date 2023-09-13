terraform {
  backend "azurerm" {
    resource_group_name  = "jb-devopstamops-rg"
    storage_account_name = "jbdevopstamopssa"
    container_name       = "tfstate"
    key                  = "acr-terraform.tfstate"
  }
}

provider "azurerm" {
    version = "~> 2.0"
    features {}
}

resource "azurerm_resource_group" "acr_resource_group" {
  name     = "jb-${var.name}-rg"
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "jb${var.name}acr"
  resource_group_name = azurerm_resource_group.acr_resource_group.name
  location            = azurerm_resource_group.acr_resource_group.location
  sku                 = "Standard"
  admin_enabled       = false
}