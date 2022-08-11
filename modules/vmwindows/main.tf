resource "azurerm_network_interface" "windows-nic" {
  name                = "${var.windows_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group
  tags                = local.common_tags

  ip_configuration {
    name                          = "${var.windows_name}-ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows-pip.id
  }
}

resource "azurerm_public_ip" "windows-pip" {
  name                = "${var.windows_name}-pip"
  resource_group_name = var.resource_group
  location            = var.location
  domain_name_label   = "${var.windows_name}-dns"
  allocation_method   = "Static"
  tags                = local.common_tags

}

resource "azurerm_windows_virtual_machine" "windows-vm" {
  name                = "${var.windows_name}-vm"
  resource_group_name = var.resource_group
  location            = var.location
  size                = var.windows_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  computer_name       = var.windows_name
  availability_set_id = azurerm_availability_set.windows-avs.id

  tags = local.common_tags

  network_interface_ids = [
    azurerm_network_interface.windows-nic.id
  ]


  os_disk {
    name                 = "${var.windows_name}-os-disk"
    caching              = var.windows_os_disk["caching"]
    storage_account_type = var.windows_os_disk["storage_account_type"]
    disk_size_gb         = var.windows_os_disk["disk_size"]
  }

  source_image_reference {
    publisher = var.windows_os["publisher"]
    offer     = var.windows_os["offer"]
    sku       = var.windows_os["sku"]
    version   = var.windows_os["version"]
  }

  winrm_listener {
    protocol = "Http"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  depends_on = [azurerm_availability_set.windows-avs]

}

resource "azurerm_availability_set" "windows-avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.resource_group
  platform_update_domain_count = var.windows_avs_values["update_domain"]
  platform_fault_domain_count  = var.windows_avs_values["fault_domain"]
}

resource "azurerm_virtual_machine_extension" "windows-vmexe" {
  name                 = "${var.windows_name}-vmexe"
  virtual_machine_id   = azurerm_windows_virtual_machine.windows-vm.id
  publisher            = var.windows_vmexe["publisher"]
  type                 = var.windows_vmexe["type"]
  type_handler_version = var.windows_vmexe["type_handler_version"]
  tags                 = local.common_tags
}