locals {
  resource_group_name  = "rg-ts-state-xsec"
  storage_account_name = "saxsectf"
  container_name       = "terraform-state"
  key                  = "terraform.tfstate"
}
