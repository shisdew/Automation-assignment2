terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate2473RG"
    storage_account_name = "tfstate2473sa"
    container_name       = "tfstatefiles"
    key                  = "z0OlLmDPeaUeT9Jnl5spd4elfvFbofraslWweYnfP+Ju7VanVpl3kHGh8Qvq4o6dTI1wFanVogQ++AStJM5jZQ=="
  }
}