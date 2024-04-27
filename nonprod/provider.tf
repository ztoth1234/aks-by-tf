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
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }

    log_analytics_workspace {
      permanently_delete_on_destroy = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = false
    }

    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = false
    }

    virtual_machine_scale_set {
      force_delete                  = false
      roll_instances_when_required  = true
      scale_to_zero_before_deletion = true
    }
  }
}

provider "azuread" {
  use_oidc = true
}
