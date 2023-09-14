terraform {
  backend "azurerm" {
    resource_group_name  = "aks-cluster-jb-tfstate-rg"
    storage_account_name = "aksjbtfstatesa"
    container_name       = "tfstate"
    key                  = "acr-terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.72.0"
    }
  }
}

provider "azurerm" {
  features {}
}
