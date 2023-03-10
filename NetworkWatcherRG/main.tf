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
