terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.33.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "self-managed-k8s-cluster-tf-state-rg"
    storage_account_name = "selfmanagedk8sstate"
    container_name       = "self-managed-k8s-cluster-tf-state-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}