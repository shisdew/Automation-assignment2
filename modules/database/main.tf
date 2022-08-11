resource "azurerm_postgresql_server" "postsql_server" {
  name                = var.postsql_server_name
  location            = var.location
  resource_group_name = var.resource_group

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  version                      = "11"
  ssl_enforcement_enabled      = true

  tags = local.common_tags
}

resource "azurerm_postgresql_database" "database" {
  name                = var.postsql_data_name
  resource_group_name = var.resource_group
  server_name         = azurerm_postgresql_server.postsql_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

}