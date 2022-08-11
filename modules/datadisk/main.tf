resource "azurerm_managed_disk" "windows_data_disk" {
  name                 = "${var.windows_name}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = local.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_data_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.windows_data_disk.id
  virtual_machine_id = var.windows_id
  lun                = var.lun
  caching            = var.data_disk_caching
  depends_on         = [azurerm_managed_disk.windows_data_disk]
}

resource "azurerm_managed_disk" "linux_data_disk" {
  for_each             = var.linux_name
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb
  tags                 = local.common_tags
  depends_on           = [var.depend_on]
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_data_disk_attach" {
  for_each           = var.linux_name
  managed_disk_id    = azurerm_managed_disk.linux_data_disk[each.key].id
  virtual_machine_id = element(var.linux_id, 0)[0][each.value]
  lun                = var.lun
  caching            = var.data_disk_caching
  depends_on         = [azurerm_managed_disk.linux_data_disk]
}