resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "MC_Vault_Xsec_Xsec_westeurope"
  tags = {
    Environment              = "Production"
    aks-managed-cluster-name = "Xsec"
    aks-managed-cluster-rg   = "Vault_Xsec"
  }
}
resource "azurerm_linux_virtual_machine_scale_set" "res-1" {
  # checkov:skip=CKV_AZURE_49: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_97: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_179: This issue is being waivered for now
  admin_username         = "azureuser"
  extensions_time_budget = "PT16M"
  instances              = 1
  location               = "westeurope"
  name                   = "aks-default-11516176-vmss"
  overprovision          = false
  resource_group_name    = "MC_Vault_Xsec_Xsec_westeurope"
  single_placement_group = false
  sku                    = "Standard_D2_v2"
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags = {
    aks-managed-coordination            = "true"
    aks-managed-createOperationID       = "6e3f2562-e2fb-4023-81b5-caf243c15bc7"
    aks-managed-creationSource          = "vmssclient-aks-default-11516176-vmss"
    aks-managed-kubeletIdentityClientID = "0f961be1-e758-4f1c-ba6b-9838dfcf8c8d"
    aks-managed-orchestrator            = "Kubernetes:1.24.9"
    aks-managed-poolName                = "default"
    aks-managed-resourceNameSuffix      = "41832928"
  }
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9K6n1Dlr1IEJRHR11NwjnA5/zXyFaV7yYfhU0zcLoB+moVQ/5ArcqkGXpalVnruz+t0oO8lR736NOypuIXKBN+Y5pSSdasHlM53wz8oL85l3IBv6wbZw5mWb9mUsNtZ7RjXmQ2/VleuWIO0T1FXFUf8PkbErXltNJuuKOmoLLSGqgp5UbrzWAGwxE5IDxDFKI1UppB8hnCRV5k4lhVR9S4TNXL3PAQBH9KlpNqbq8HdVmtY4+64rvybMeyyUQV2t4y8fxvl8/lU6dWMtFgM0QCKw3XE1hMjJ6FaKs6eEQUQMgOHGkeVmGNYEt+3jcx/SwHXrGN7yZw2O7BzlvJ+jJT1omxCKtrjCVv4GitISx2E5xXwqsgCSoCdGHHdUH5K85mZHv8jIsQPkxKh3/6M0vYl/T1dt/IWqd4UG911EhNDQuUX9VNhaR0LR6wF67b2qjs1BsrTX8Ge4oS7czkk82pJ7tyhsbllAt/fpbpFV8mMXUr0lIybZWbA8gsM+LsKEgPi3Dp6uJvdjICy6jDNKgNjWWxpXvUvpE6Gz6YB0lZ3ds/535jiSDtC9x8m/6RjmwykB6K+dEKu+yMSu6n6nbZ+m3MKL5weCHPvZZ4gBle9CqJJbA/6ziTKmF9atzckTH+SNTNDtVRUJX++NRotAT/tW/KYuu4VjOK0bgmJT1+w==\n"
    username   = "azureuser"
  }
  identity {
    identity_ids = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.ManagedIdentity/userAssignedIdentities/Xsec-agentpool"]
    type         = "UserAssigned"
  }
  network_interface {
    enable_accelerated_networking = true
    enable_ip_forwarding          = true
    name                          = "aks-default-11516176-vmss"
    primary                       = true
    ip_configuration {
      load_balancer_backend_address_pool_ids = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/loadBalancers/kubernetes/backendAddressPools/aksOutboundBackendPool", "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/loadBalancers/kubernetes/backendAddressPools/kubernetes"]
      name                                   = "ipconfig1"
      primary                                = true
      subnet_id                              = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vnet-41832928/subnets/aks-subnet"
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  depends_on = [
    azurerm_user_assigned_identity.res-9,
    # One of azurerm_subnet.res-13,azurerm_subnet_network_security_group_association.res-14,azurerm_subnet_route_table_association.res-15 (can't auto-resolve as their ids are identical)
  ]
}
# resource "azurerm_virtual_machine_scale_set_extension" "res-2" {
#   auto_upgrade_minor_version   = false
#   name                         = "AKSLinuxExtension"
#   provision_after_extensions   = ["vmssCSE"]
#   publisher                    = "Microsoft.AKS"
#   type                         = "Compute.AKS.Linux.AKSNode"
#   type_handler_version         = "1.39"
#   virtual_machine_scale_set_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Compute/virtualMachineScaleSets/aks-default-11516176-vmss"
#   depends_on = [
#     azurerm_linux_virtual_machine_scale_set.res-1,
#   ]
# }
# resource "azurerm_virtual_machine_scale_set_extension" "res-3" {
#   name                         = "aks-default-11516176-vmss-AKSLinuxBilling"
#   publisher                    = "Microsoft.AKS"
#   type                         = "Compute.AKS.Linux.Billing"
#   type_handler_version         = "1.0"
#   virtual_machine_scale_set_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Compute/virtualMachineScaleSets/aks-default-11516176-vmss"
#   depends_on = [
#     azurerm_linux_virtual_machine_scale_set.res-1,
#   ]
# }
# resource "azurerm_virtual_machine_scale_set_extension" "res-4" {
#   name                         = "vmssCSE"
#   publisher                    = "Microsoft.Azure.Extensions"
#   type                         = "CustomScript"
#   type_handler_version         = "2.0"
#   virtual_machine_scale_set_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Compute/virtualMachineScaleSets/aks-default-11516176-vmss"
#   depends_on = [
#     azurerm_linux_virtual_machine_scale_set.res-1,
#   ]
# }
resource "azurerm_user_assigned_identity" "res-9" {
  location            = "westeurope"
  name                = "Xsec-agentpool"
  resource_group_name = "MC_Vault_Xsec_Xsec_westeurope"
  tags = {
    Environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_public_ip" "res-10" {
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
  location                = "westeurope"
  name                    = "a904ed7a-878b-408b-9853-61b6dad3c094"
  resource_group_name     = "MC_Vault_Xsec_Xsec_westeurope"
  sku                     = "Standard"
  tags = {
    Environment              = "Production"
    aks-managed-cluster-name = "Xsec"
    aks-managed-cluster-rg   = "Vault_Xsec"
    aks-managed-type         = "aks-slb-managed-outbound-ip"
  }
  zones = ["1", "2", "3"]
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_route_table" "res-11" {
  location            = "westeurope"
  name                = "aks-agentpool-41832928-routetable"
  resource_group_name = "MC_Vault_Xsec_Xsec_westeurope"
  tags = {
    Environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-12" {
  address_space       = ["10.224.0.0/12"]
  location            = "westeurope"
  name                = "aks-vnet-41832928"
  resource_group_name = "MC_Vault_Xsec_Xsec_westeurope"
  tags = {
    Environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_subnet" "res-13" {
  address_prefixes     = ["10.224.0.0/16"]
  name                 = "aks-subnet"
  resource_group_name  = "MC_Vault_Xsec_Xsec_westeurope"
  virtual_network_name = "aks-vnet-41832928"
  depends_on = [
    azurerm_virtual_network.res-12,
  ]
}
resource "azurerm_subnet_network_security_group_association" "res-14" {
  network_security_group_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/networkSecurityGroups/aks-agentpool-41832928-nsg"
  subnet_id                 = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vnet-41832928/subnets/aks-subnet"
  depends_on = [
    # One of azurerm_subnet.res-13,azurerm_subnet_route_table_association.res-15 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_subnet_route_table_association" "res-15" {
  route_table_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/routeTables/aks-agentpool-41832928-routetable"
  subnet_id      = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/MC_Vault_Xsec_Xsec_westeurope/providers/Microsoft.Network/virtualNetworks/aks-vnet-41832928/subnets/aks-subnet"
  depends_on = [
    azurerm_route_table.res-11,
    # One of azurerm_subnet.res-13,azurerm_subnet_network_security_group_association.res-14 (can't auto-resolve as their ids are identical)
  ]
}
resource "azurerm_lb" "res-16" {
  location            = "westeurope"
  name                = "kubernetes"
  resource_group_name = "mc_vault_xsec_xsec_westeurope"
  sku                 = "Standard"
  tags = {
    Environment              = "Production"
    aks-managed-cluster-name = "Xsec"
    aks-managed-cluster-rg   = "Vault_Xsec"
  }
  frontend_ip_configuration {
    name = "a904ed7a-878b-408b-9853-61b6dad3c094"
  }
  frontend_ip_configuration {
    name = "ad79f800b9a9446748c36c88e45bd72d"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_lb_backend_address_pool" "res-17" {
  loadbalancer_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/mc_vault_xsec_xsec_westeurope/providers/Microsoft.Network/loadBalancers/kubernetes"
  name            = "aksOutboundBackendPool"
  depends_on = [
    azurerm_lb.res-16,
  ]
}
resource "azurerm_lb_backend_address_pool" "res-18" {
  loadbalancer_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/mc_vault_xsec_xsec_westeurope/providers/Microsoft.Network/loadBalancers/kubernetes"
  name            = "kubernetes"
  depends_on = [
    azurerm_lb.res-16,
  ]
}
resource "azurerm_network_security_group" "res-19" {
  location            = "westeurope"
  name                = "aks-agentpool-41832928-nsg"
  resource_group_name = "mc_vault_xsec_xsec_westeurope"
  tags = {
    Environment = "Production"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-20" {
  access                      = "Allow"
  destination_address_prefix  = "20.4.161.180"
  destination_port_range      = "8200"
  direction                   = "Inbound"
  name                        = "ad79f800b9a9446748c36c88e45bd72d-TCP-8200-Internet"
  network_security_group_name = "aks-agentpool-41832928-nsg"
  priority                    = 500
  protocol                    = "Tcp"
  resource_group_name         = "mc_vault_xsec_xsec_westeurope"
  source_address_prefix       = "Internet"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-19,
  ]
}
resource "azurerm_public_ip" "res-21" {
  allocation_method   = "Static"
  location            = "westeurope"
  name                = "kubernetes-ad79f800b9a9446748c36c88e45bd72d"
  resource_group_name = "mc_vault_xsec_xsec_westeurope"
  sku                 = "Standard"
  tags = {
    Environment            = "Production"
    k8s-azure-cluster-name = "kubernetes"
    k8s-azure-service      = "default/hcvault-ui"
  }
  zones = ["1", "2", "3"]
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_route" "res-22" {
  address_prefix         = "10.244.0.0/24"
  name                   = "aks-default-11516176-vmss000000____102440024"
  next_hop_in_ip_address = "10.224.0.4"
  next_hop_type          = "VirtualAppliance"
  resource_group_name    = "mc_vault_xsec_xsec_westeurope"
  route_table_name       = "aks-agentpool-41832928-routetable"
  depends_on = [
    azurerm_route_table.res-11,
  ]
}
