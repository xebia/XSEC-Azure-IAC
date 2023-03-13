terraform {
  backend "azurerm" {
    resource_group_name  = var.backend.resourcegroupname
    storage_account_name = var.backend.storageaccountname
    container_name       = var.backend.containername
    key                  = "${path.module}".var.backend.key
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}
