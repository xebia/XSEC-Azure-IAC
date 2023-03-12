terraform {
  backend "azurerm" {
    resource_group_name  = "xsecpipelinetest-tfstate-rg"
    storage_account_name = "xsecpipelinetesttfvjcib"
    container_name       = "core-tfstate"
    key                  = "TuJGoNcS8xKVGmfc17haiNCDeY1U2z4Mhf9zVYEss555b09k2qa9f2DOPb2YjQc2jqAZhNaZk+Oc+AStEEalQA=="
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

