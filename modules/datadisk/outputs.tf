output "windows_data_disk" {
  value = azurerm_managed_disk.windows_data_disk
}

output "windows_data_disk_attach" {
  value = azurerm_virtual_machine_data_disk_attachment.windows_data_disk_attach
}

output "linux_data_disk" {
  value = [azurerm_managed_disk.windows_data_disk[*]]
}

output "linux_data_disk_attach" {
  value = [azurerm_virtual_machine_data_disk_attachment.windows_data_disk_attach[*]]
}