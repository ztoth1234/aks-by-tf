variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
  default     = "westeurope"
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

variable "resource_groups" {
  description = "Resource groups for nonprod."
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    rg1 = {
      name     = "rg-aks-network-nonprod-weu-01"
      location = "westeurope"
    }
    rg2 = {
      name     = "rg-aks-monitor-nonprod-weu-01"
      location = "westeurope"
    }
    rg3 = {
      name     = "rg-aks-paas-nonprod-weu-01"
      location = "westeurope"
    }
    rg4 = {
      name     = "rg-aks-cluster-nonprod-weu-01"
      location = "westeurope"
    }
    rg5 = {
      name     = "rg-aks-remote-nonprod-weu-01",
      location = "westeurope"
    }
  }
}
