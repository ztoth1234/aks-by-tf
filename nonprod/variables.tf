variable "backend_resource_group_name" {
  description = "The name of the backend resource group"
  type        = string
  default     = "rg-tfstate-nonprod-weu-01"
}

variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
  default     = "westeurope"
}

variable "backend_storage_account_name" {
  description = "The name of the backend storage account."
  type        = string
  default     = "tfstatenonprodre0zt"
}

variable "backend_storage_container_name" {
  description = "The name of the backend storage container."
  type        = string
  default     = "tfstate-nonprod"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default = {
    "ApplicationID"       = "AP000000000"
    "ApplicationName"     = "ZT Lab PoC"
    "Environment"         = "NonProd"
    "GitHubRepoReference" = "https://github.com/ztoth1234/aks-by-tf"
  }
}