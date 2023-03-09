resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "tfstate"
}
resource "azurerm_storage_account" "res-1" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = "eastus"
  min_tls_version          = "TLS1_0"
  name                     = "tfstate182367161"
  resource_group_name      = "tfstate"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_container" "res-3" {
  container_access_type = "blob"
  name                  = "tfstate"
  storage_account_name  = "tfstate182367161"
}
