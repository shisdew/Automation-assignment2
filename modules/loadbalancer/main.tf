resource "azurerm_public_ip" "loadbalancer-pubip" {
  count               = 2
  name                = "${var.loadbalancer-pubip}-lbpip-${format("%1d", count.index + 1)}"
  location            = var.location
  resource_group_name = var.resource_group
  domain_name_label   = "lbdns-4${format("%1d", count.index + 1)}"
  allocation_method   = "Static"
  tags                = local.common_tags
}

resource "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer["name"]
  location            = var.location
  resource_group_name = var.resource_group

  frontend_ip_configuration {
    name                 = "PublicIPAddress_1"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pubip[0].id
  }

  frontend_ip_configuration {
    name                 = "PublicIPAddress_2"
    public_ip_address_id = azurerm_public_ip.loadbalancer-pubip[1].id
  }

  tags = local.common_tags
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  loadbalancer_id = azurerm_lb.loadbalancer.id
  name            = var.backend_address_pool
}

resource "azurerm_network_interface_backend_address_pool_association" "loadbalancer_pool_association" {
  for_each                = var.linux_name
  network_interface_id    = element(var.linux_network_interface_id, 0)[0][each.value]
  ip_configuration_name   = "linux-ipconfig-${each.value + 1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_address_pool.id
}

resource "azurerm_lb_rule" "loadbalancer_rule" {
  count                          = 2
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  name                           = "${var.loadbalancer_rule["name"]}-${format("%1d", count.index + 1)}"
  protocol                       = var.loadbalancer_rule["protocol"]
  frontend_port                  = var.loadbalancer_rule["frontend_port"]
  backend_port                   = var.loadbalancer_rule["backend_port"]
  frontend_ip_configuration_name = "PublicIPAddress_${format("%1d", count.index + 1)}"
}

resource "azurerm_lb_probe" "loadbalancer_probe" {
  loadbalancer_id     = azurerm_lb.loadbalancer.id
  name                = var.loadbalancer_probe["name"]
  protocol            = var.loadbalancer_probe["protocol"]
  port                = var.loadbalancer_probe["port"]
  interval_in_seconds = var.loadbalancer_probe["interval_in_seconds"]
  number_of_probes    = var.loadbalancer_probe["number_of_probes"]
}