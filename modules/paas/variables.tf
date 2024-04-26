variable "acr_name" {
  description = "Specifies the name of the Azure Container Registry component."
  type        = string
}

variable "location" {
  description = " Specifies the supported Azure location where the resource exists. "
  type        = string
}

variable "resourcegroup_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
}

variable "law_id" {
  description = "The Log Analytics Workspace ID."
  type        = string
}
