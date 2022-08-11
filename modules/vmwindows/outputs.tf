output "Windows_hostname" {
  value = azurerm_windows_virtual_machine.windows-vm.name
}

output "Windows_public_ip_addresses" {
  value = azurerm_windows_virtual_machine.windows-vm.public_ip_address
}

output "Windows_private_ip_address" {
  value = azurerm_windows_virtual_machine.windows-vm.private_ip_address
}

output "Windows_dns" {
  value = azurerm_public_ip.windows-pip.domain_name_label
}

output "Windows_vm" {
  value = azurerm_windows_virtual_machine.windows-vm
}