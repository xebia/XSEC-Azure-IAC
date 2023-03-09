resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "sdebruin_rg_2688"
}
resource "azurerm_service_plan" "res-1" {
  location            = "westeurope"
  name                = "sdebruin_asp_3514"
  os_type             = "Linux"
  resource_group_name = "sdebruin_rg_2688"
  sku_name            = "B1"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
