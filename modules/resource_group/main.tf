resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group
  location = var.location
  tags     = local.common_tags
}



