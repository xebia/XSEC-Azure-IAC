# Generate a random storage name
resource "random_string" "tf-name" {
  length = 8
  upper = false
  numeric = true
  lower = true
  special = false
}

resource "random_string" "tf-name2" {
  length = 5
  upper = false
  numeric = false
  lower = true
  special = false
}
# Create a Resource Group for the Terraform State File
resource "azurerm_resource_group" "state-rg" {
  name = "${lower(var.company)}-tfstate-rg"
  location = local.location
  
  lifecycle {
    prevent_destroy = true
  }  
  tags = {
    environment = var.environment
  }
}
# Create a Storage Account for the Terraform State File
resource "azurerm_storage_account" "state-sta" {
	# checkov:skip=CKV_AZURE_59: test1
	# checkov:skip=CKV_AZURE_33: For Testing Reasons, waivering risk
	# checkov:skip=CKV2_AZURE_1: For Testing Reasons, waivering risk
	# checkov:skip=CKV2_AZURE_18: For Testing Reasons, waivering risk
	# checkov:skip=CKV_AZURE_44: For Testing Reasons, waivering risk
  # checkov:skip=CKV_AZURE_190: test2
  # checkov:skip=CKV_AZURE_206: test2
  depends_on = [azurerm_resource_group.state-rg]  
  name = "${lower(var.company)}tf${random_string.tf-name2.result}"
  resource_group_name = azurerm_resource_group.state-rg.name
  location = azurerm_resource_group.state-rg.location
  account_kind = "StorageV2"
  account_tier = "Standard"
  access_tier = "Hot"
  account_replication_type = "ZRS"
  enable_https_traffic_only = true
   
  lifecycle {
    prevent_destroy = true
  }  
  
  tags = {
    environment = var.environment
  }
}
# Create a Storage Container for the Core State File
resource "azurerm_storage_container" "core-container" {
	# checkov:skip=CKV2_AZURE_21: For Testing Reasons, waivering risk
  depends_on = [azurerm_storage_account.state-sta]  
  name = "core-tfstate"
  storage_account_name = azurerm_storage_account.state-sta.name
}

output "terraform_state_resource_group_name" {
  value = azurerm_resource_group.state-rg.name
}
output "terraform_state_storage_account" {
  value = azurerm_storage_account.state-sta.name
}
output "terraform_state_storage_container_core" {
  value = azurerm_storage_container.core-container.name
}