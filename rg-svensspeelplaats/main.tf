resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "rg-svensspeelplaats"
}
resource "azurerm_application_insights" "res-1" {
  application_type    = "web"
  location            = "westeurope"
  name                = "appinsights-svensspeelplaats"
  resource_group_name = "rg-svensspeelplaats"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_key_vault" "res-2" {
  # checkov:skip=CKV_AZURE_42: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_110: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_109: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_189: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_212: This issue is being waivered for now
  # checkov:skip=CKV2_AZURE_32: This issue is being waivered for now
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  location                        = "westeurope"
  name                            = "kvsvensspeelplaats"
  resource_group_name             = "rg-svensspeelplaats"
  sku_name                        = "standard"
  tenant_id                       = "3d4d17ea-1ae4-4705-947e-51369c5a5f79"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_storage_account" "res-3" {
  # checkov:skip=CKV_AZURE_59: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_44: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_190: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_206: This issue is being waivered for now
  # checkov:skip=CKV2_AZURE_18: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_33: This issue is being waivered for now
  # checkov:skip=CKV2_AZURE_1: This issue is being waivered for now
  # checkov:skip=CKV2_AZURE_33: This issue is being waivered for now
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = "westeurope"
  name                     = "sasvensspeelplaats"
  resource_group_name      = "rg-svensspeelplaats"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_service_plan" "res-8" {
  location            = "westeurope"
  name                = "appservice-plan-svensspeelplaats"
  os_type             = "Windows"
  resource_group_name = "rg-svensspeelplaats"
  sku_name            = "S1"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_windows_function_app" "res-9" {
  client_certificate_mode     = "Required"
  functions_extension_version = "~1"
  location                    = "westeurope"
  name                        = "functionapp-svensspeelplaats"
  resource_group_name         = "rg-svensspeelplaats"
  service_plan_id             = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/rg-svensspeelplaats/providers/Microsoft.Web/serverfarms/appservice-plan-svensspeelplaats"
  storage_account_access_key  = "lbsX/kTv409JRzK0fN3lXO4ClLamFpy4sZwrW13GSiM+vZ6iDJUzA1y6JRIsEt87f6I8orWiYiW1+AStvmJBbw=="
  storage_account_name        = "sasvensspeelplaats"
  site_config {
    application_insights_connection_string = "InstrumentationKey=2d42f3a1-8f13-46ed-9b97-207107976bfc"
    application_insights_key               = "2d42f3a1-8f13-46ed-9b97-207107976bfc"
    ftps_state                             = "AllAllowed"
  }
  depends_on = [
    azurerm_service_plan.res-8,
  ]
}
resource "azurerm_app_service_custom_hostname_binding" "res-13" {
  app_service_name    = "functionapp-svensspeelplaats"
  hostname            = "functionapp-svensspeelplaats.azurewebsites.net"
  resource_group_name = "rg-svensspeelplaats"
  depends_on = [
    azurerm_windows_function_app.res-9,
  ]
}
resource "azurerm_monitor_smart_detector_alert_rule" "res-31" {
  description         = "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls."
  detector_type       = "FailureAnomaliesDetector"
  frequency           = "PT1M"
  name                = "Failure Anomalies - appinsights-svensspeelplaats"
  resource_group_name = "rg-svensspeelplaats"
  scope_resource_ids  = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourcegroups/rg-svensspeelplaats/providers/microsoft.insights/components/appinsights-svensspeelplaats"]
  severity            = "Sev3"
  action_group {
    ids = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourcegroups/rg-svensspeelplaats/providers/microsoft.insights/actiongroups/application insights smart detection"]
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_monitor_action_group" "res-32" {
  name                = "Application Insights Smart Detection"
  resource_group_name = "rg-svensspeelplaats"
  short_name          = "SmartDetect"
  arm_role_receiver {
    name                    = "Monitoring Contributor"
    role_id                 = "749f88d5-cbae-40b8-bcfc-e573ddc772fa"
    use_common_alert_schema = true
  }
  arm_role_receiver {
    name                    = "Monitoring Reader"
    role_id                 = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
    use_common_alert_schema = true
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
