locals {
  common_tags = {
    Project        = "Automation Project-Assignment 2"
    Name           = "Hamidur Rahman"
    ExpirationDate = "2022-08-20"
    Enviroment     = "Lab"
  }
}


variable "resource_group" {
  default = ""
}

variable "location" {
  default = ""
}
