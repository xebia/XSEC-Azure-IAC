resource "azurerm_resource_group" "res-0" {
  location = "westeurope"
  name     = "Maikel-Playground_ASML"
}
resource "azurerm_windows_virtual_machine" "res-1" {
  # checkov:skip=CKV_AZURE_50: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_151: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_177: This issue is being waivered for now
  # checkov:skip=CKV_AZURE_179: This issue is being waivered for now
  # checkov:skip=CKV_SECRET_80: This issue is being waivered for now
  admin_password        = "Thisisatest56!"
  admin_username        = "maikelvanamen1"
  license_type          = "Windows_Client"
  location              = "westeurope"
  name                  = "xsecBeast"
  network_interface_ids = ["/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Maikel-Playground_ASML/providers/Microsoft.Network/networkInterfaces/xsecbeast411"]
  resource_group_name   = "Maikel-Playground_ASML"
  size                  = "Standard_D2s_v3"
  tags = {
    "Created By" = "Maikel van Amen"
  }
  boot_diagnostics {
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  source_image_reference {
    offer     = "windows-11"
    publisher = "microsoftwindowsdesktop"
    sku       = "win11-21h2-pro"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-2,
  ]
}
resource "azurerm_network_interface" "res-2" {
  # checkov:skip=CKV_AZURE_119: This issue is being waivered for now
  enable_accelerated_networking = true
  location                      = "westeurope"
  name                          = "xsecbeast411"
  resource_group_name           = "Maikel-Playground_ASML"
  tags = {
    "Created By" = "Maikel van Amen"
  }
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Maikel-Playground_ASML/providers/Microsoft.Network/publicIPAddresses/xsecBeast-ip"
    subnet_id                     = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Maikel-Playground_ASML/providers/Microsoft.Network/virtualNetworks/Maikel-Playground_ASML-vnet/subnets/default"
  }
  depends_on = [
    azurerm_public_ip.res-7,
    azurerm_subnet.res-10,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-3" {
  network_interface_id      = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Maikel-Playground_ASML/providers/Microsoft.Network/networkInterfaces/xsecbeast411"
  network_security_group_id = "/subscriptions/1a0d078e-b0e6-432d-89c7-8a75cac664aa/resourceGroups/Maikel-Playground_ASML/providers/Microsoft.Network/networkSecurityGroups/xsecBeast-nsg"
  depends_on = [
    azurerm_network_interface.res-2,
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_network_security_group" "res-4" {
  location            = "westeurope"
  name                = "xsecBeast-nsg"
  resource_group_name = "Maikel-Playground_ASML"
  tags = {
    "Created By" = "Maikel van Amen"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_network_security_rule" "res-5" {
  # checkov:skip=CKV_AZURE_9: This issue is being waivered for now
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "3389"
  direction                   = "Inbound"
  name                        = "RDP"
  network_security_group_name = "xsecBeast-nsg"
  priority                    = 300
  protocol                    = "Tcp"
  resource_group_name         = "Maikel-Playground_ASML"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-4,
  ]
}
resource "azurerm_public_ip" "res-6" {
  allocation_method   = "Static"
  location            = "westeurope"
  name                = "Maikel-Playground_ASML-vnet-ip"
  resource_group_name = "Maikel-Playground_ASML"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_public_ip" "res-7" {
  allocation_method   = "Static"
  location            = "westeurope"
  name                = "xsecBeast-ip"
  resource_group_name = "Maikel-Playground_ASML"
  sku                 = "Standard"
  tags = {
    "Created By" = "Maikel van Amen"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_virtual_network" "res-8" {
  address_space       = ["10.0.0.0/16"]
  location            = "westeurope"
  name                = "Maikel-Playground_ASML-vnet"
  resource_group_name = "Maikel-Playground_ASML"
  tags = {
    "Created By" = "Maikel van Amen"
  }
  depends_on = [
    azurerm_resource_group.res-0,
  ]
}
resource "azurerm_subnet" "res-9" {
  address_prefixes     = ["10.0.1.0/26"]
  name                 = "AzureBastionSubnet"
  resource_group_name  = "Maikel-Playground_ASML"
  virtual_network_name = "Maikel-Playground_ASML-vnet"
  depends_on = [
    azurerm_virtual_network.res-8,
  ]
}
resource "azurerm_subnet" "res-10" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "default"
  resource_group_name  = "Maikel-Playground_ASML"
  virtual_network_name = "Maikel-Playground_ASML-vnet"
  depends_on = [
    azurerm_virtual_network.res-8,
  ]
}
