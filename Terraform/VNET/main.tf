terraform {
  backend "azurerm" {
    resource_group_name  = "aks-cluster-jb-tfstate-rg"
    storage_account_name = "aksjbtfstatesa"
    container_name       = "tfstate"
    key                  = "vnet-terraform.tfstate"
  }
}

provider "azurerm" {
    version = "~> 2.0"
    features {}
}

