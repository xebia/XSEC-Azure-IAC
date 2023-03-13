terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ts-state-xsec"
    storage_account_name = "saxsectf"
    container_name       = "terraform-state"
    key                  = "test/terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.46.0"
    }
  }
}
