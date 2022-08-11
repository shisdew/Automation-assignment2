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

variable "admin_username" {
  default = "shisdew"
}

variable "admin_password" {
  default = "Shi5leo!"
}

variable "postsql_server_name" {
  default = "postgresql-server-2473"
}

variable "postsql_data_name" {
  default = "database"
}