terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.6.0"
    }
  }
  required_version = "~> 1.2.4"
}

provider "azurerm" {
  features {}
}
