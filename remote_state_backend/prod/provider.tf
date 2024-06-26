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
}

provider "azurerm" {
  use_oidc = true
  #skip_provider_registration = true
  #storage_use_azuread        = true
  features {}
}

provider "azuread" {
  use_oidc = true
}
