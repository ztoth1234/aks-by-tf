terraform {
  required_version = ">= 1.7.0"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      #      version = "~> 3.29"
      version = "3.91.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.47.0"
    }
  }
}

provider "azurerm" {
  use_oidc  = true
  tenant_id = "06227e75-88cb-424f-8b1e-62a07888a6ba"
  #skip_provider_registration = true
  #storage_use_azuread        = true
  features {}
}

provider "azuread" {
  use_oidc = true
}
