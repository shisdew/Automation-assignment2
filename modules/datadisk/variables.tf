locals {
  common_tags = {
    Project        = "Automation Project-Assignment 2"
    Name           = "Mohammed Solaiman Dewan"
    ExpirationDate = "2022-08-30"
    Enviroment     = "Lab"
  }
}

variable "depend_on" {
  default = ""
}

variable "resource_group" {
  default = ""
}

variable "location" {
  default = ""
}

variable "windows_id" {
  default = ""
}

variable "linux_id" {
  default = ""
}

variable "windows_name" {
  default = ""
}

variable "linux_name" {
  default = ""
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "create_option" {
  default = "Empty"
}

variable "disk_size_gb" {
  default = 10
}

variable "lun" {
  default = 0
}

variable "data_disk_caching" {
  default = "ReadWrite"
}
