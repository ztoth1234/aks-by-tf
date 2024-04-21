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
  use_oidc                   = true // OIDC will be used for authentication if set to true. If you want to use SPN secret set to false
  skip_provider_registration = true
  storage_use_azuread        = true
  features {}
}

provider "azuread" {
  use_oidc = true
}
