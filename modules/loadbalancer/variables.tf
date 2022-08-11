locals {
  common_tags = {
    Project        = "Automation Project-Assignment 2"
    Name           = "Mohammed Solaiman Dewan"
    ExpirationDate = "2022-08-30"
    Enviroment     = "Lab"
  }
}

variable "resource_group" {
  default = ""
}

variable "location" {
  default = ""
}

variable "linux_network_interface_id" {
  default = ""
}

variable "linux_network_interface_name" {
  default = ""
}

variable "linux_pip_id" {
  default = ""
}

variable "linux_name" {
  default = ""
}

variable "loadbalancer-pubip" {
  default = "loadbalancer-pubip"
}

variable "loadbalancer" {
  type = map(string)
  default = {
    name                      = "loadbalancer"
    frontend_ip_configuration = "pubip"
  }
}

variable "backend_address_pool" {
  default = "backendaddresspool"
}

variable "loadbalancer_pool_association" {
  default = "loadbalancer-pool-association"
}

variable "loadbalancer_rule" {
  type = map(string)
  default = {
    name                           = "loadbalancer-rule"
    protocol                       = "Tcp"
    frontend_port                  = 3389
    backend_port                   = 3389
    frontend_ip_configuration_name = "PublicIPAddress"
  }
}

variable "loadbalancer_probe" {
  type = map(string)
  default = {
    name                = "loadbalancer-probe"
    protocol            = "Tcp"
    port                = 80
    interval_in_seconds = 5
    number_of_probes    = 2
  }
}