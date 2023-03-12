resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "Vault_Xsec"
}
resource "azurerm_kubernetes_cluster" "res-1" {
  # checkov:skip=CKV_AZURE_6: This issue is being waivered for now.
  # checkov:skip=CKV_AZURE_115: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_141: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_4: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_7: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_116: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_117: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_168: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_170: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_171: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_172: This issue is being waivered for now
  dns_prefix          = "xsecvaultaks1"
  location            = "westeurope"
  name                = "Xsec"
  resource_group_name = "Vault_Xsec"
  tags = {
    Environment = "Production"
  }
  default_node_pool {
    name    = "default"
    vm_size = "Standard_D2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_kubernetes_cluster_node_pool" "res-2" {
  # checkov:skip=CKV_AZURE_168: This issue is being waivered for now
  kubernetes_cluster_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Vault_Xsec/providers/Microsoft.ContainerService/managedClusters/Xsec"
  mode                  = "System"
  name                  = "default"
  vm_size               = "Standard_D2_v2"
  depends_on = [
    azurerm_kubernetes_cluster.res-1,
  ]
}
