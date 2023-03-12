resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "testdeploymentBicep"
}
resource "azurerm_service_plan" "res-1" {
  # checkov:skip=CKV_AZURE_212: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_213: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_214: This issue is being waivered for now
  location            = "westeurope"
  name                = "ca-service-plan"
  os_type             = "Windows"
  resource_group_name = "testdeploymentBicep"
  sku_name            = "S1"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_windows_web_app" "res-2" {
  # checkov:skip=CKV_AZURE_13: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_17: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_65: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_66: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_78: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_63: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_18: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_16: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_71: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_88: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_213: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_214: This issue is being waivered for now
  client_affinity_enabled = true
  https_only              = true
  location                = "westeurope"
  name                    = "cawebapp32yfmbpnveu6k"
  resource_group_name     = "testdeploymentBicep"
  service_plan_id         = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/testdeploymentBicep/providers/Microsoft.Web/serverfarms/ca-service-plan"
  site_config {
    always_on  = false
    ftps_state = "AllAllowed"
    virtual_application {
      physical_path = "site\\wwwroot"
      preload       = false
      virtual_path  = "/"
    }
  }
  depends_on = [
    azurerm_service_plan.res-1,
  ]
}
# resource "azurerm_app_service_custom_hostname_binding" "res-6" {
#   app_service_name    = "cawebapp32yfmbpnveu6k"
#   hostname            = "cawebapp32yfmbpnveu6k.azurewebsites.net"
#   resource_group_name = "testdeploymentBicep"
#   depends_on = [
#     azurerm_windows_web_app.res-2,
#   ]
# }
