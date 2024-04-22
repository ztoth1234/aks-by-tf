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