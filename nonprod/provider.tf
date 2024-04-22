terraform {
  required_version = ">= 1.8.1"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      #      version = "~> 3.29"
      version = "3.100.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.48.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-nonprod-weu-01"
    storage_account_name = "tfstatenonprodre0zt"
    container_name       = "tfstate-nonprod"
    key                  = "nonprod.terraform.tfstate"
    use_oidc             = true
  }
}

provider "azurerm" {
  use_oidc            = true
  storage_use_azuread = true
  features {}
}

provider "azuread" {
  use_oidc = true
}
