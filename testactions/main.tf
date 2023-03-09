resource "azurerm_resource_group" "hashicorp_vault_xsec_resource_group" {
  name     = local.vault_resource_group_name
  location = local.location
}
