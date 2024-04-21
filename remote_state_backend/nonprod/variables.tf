variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account."
  type        = string
  default     = "rg-tfstate-nonprod-weu-01"
}

variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
  default     = "westeurope"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
  default     = "tfstatenonprodre0zt"
}

variable "storage_container_name" {
  description = "The name of the storage container."
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
