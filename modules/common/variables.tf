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

variable "log_analytics_workspace" {
  type = map(string)
  default = {
    name        = "log-analytics-workspace"
    sku         = "PerGB2018"
    ret-in-days = 30
  }
}

variable "recovery_services_vault" {
  type = map(string)
  default = {
    name = "vault"
    sku  = "Standard"
  }
}
variable "storage_account" {
  type = map(string)
  default = {
    name                     = "assignment2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

variable "storage_container" {
  type = map(string)
  default = {
    name                  = "storage-container"
    container_access_type = "private"
  }
}

variable "storage_blob" {
  type = map(string)
  default = {
    name = "storage_blob"
    type = "Block"
  }
}
