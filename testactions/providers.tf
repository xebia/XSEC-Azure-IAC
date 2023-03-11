terraform {
  # backend "azurerm" {
  #   resource_group_name  = "XSECpipelinetest-tfstate-rg"
  #   storage_account_name = "XSECpipelinetesttfxsecxebiastate"
  #   container_name       = "core-tfstate"
  #   key                  = "nCZw6/N5EXUTeP3WzcT9kPnyg1r7gbc4i7sq8gHgfLQ7hwUiw5LI8iF+r1Np3uNK8Bg/r9rVBHWd+AStnS0u3w=="
  # }
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

