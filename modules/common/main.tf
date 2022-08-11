resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace["name"]
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.log_analytics_workspace["sku"]
  retention_in_days   = var.log_analytics_workspace["ret-in-days"]
  tags                = local.common_tags
}

resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  name                = var.recovery_services_vault["name"]
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = var.recovery_services_vault["sku"]

  soft_delete_enabled = true
  tags                = local.common_tags
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account["name"]
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.storage_account["account_tier"]
  account_replication_type = var.storage_account["account_replication_type"]

  tags = local.common_tags
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.storage_container["name"]
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.storage_container["container_access_type"]
}

resource "azurerm_storage_blob" "storage_blob" {
  name                   = var.storage_blob["name"]
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container.name
  type                   = var.storage_blob["type"]
}