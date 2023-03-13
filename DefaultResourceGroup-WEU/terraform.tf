terraform {
  backend "azurerm" {
    resource_group_name  = local.resourcegroupname
    storage_account_name = local.storageaccountname
    container_name       = local.containername
    key                  = ${path.module}.local.keytfstate
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}
