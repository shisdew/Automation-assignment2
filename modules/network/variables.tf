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

variable "vnet" {
  default = "virtual-network"
}

variable "vnet_space" {
  default = ["10.0.0.0/16"]
}

variable "subnet" {
  default = "subnet"
}

variable "subnet_space" {
  default = ["10.0.1.0/24"]
}