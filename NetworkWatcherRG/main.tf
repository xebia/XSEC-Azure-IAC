resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "NetworkWatcherRG"
}
resource "azurerm_network_watcher" "res-1" {
  location            = "eastus"
  name                = "NetworkWatcher_eastus"
  resource_group_name = "NetworkWatcherRG"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_watcher" "res-2" {
  location            = "westeurope"
  name                = "NetworkWatcher_westeurope"
  resource_group_name = "NetworkWatcherRG"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_watcher" "res-3" {
  location            = "westindia"
  name                = "NetworkWatcher_westindia"
  resource_group_name = "NetworkWatcherRG"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_watcher_flow_log" "res-4" {
  # checkov:skip=CKV_AZURE_12: This issue is being waivered for now
  enabled                   = true
  name                      = "xsecBeast-nsg-maikel-playground_asml-flowlog"
  network_security_group_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Maikel-Playground_ASML/providers/Microsoft.Network/networkSecurityGroups/xsecBeast-nsg"
  network_watcher_name      = "NetworkWatcher_westeurope"
  resource_group_name       = "NetworkWatcherRG"
  storage_account_id        = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/prisma-cloud-resources/providers/Microsoft.Storage/storageAccounts/nsfflowlogsforprisma"
  retention_policy {
    days    = 30
    enabled = true
  }
  depends_on = [
    azurerm_network_watcher.res-2,
  ]
}
