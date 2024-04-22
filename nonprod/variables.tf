variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
  default     = "westeurope"
}

variable "backend_resource_group_name" {
  description = "The name of the backend resource group"
  type        = string
}

variable "backend_storage_account_name" {
  description = "The name of the backend storage account."
  type        = string
}

variable "backend_storage_container_name" {
  description = "The name of the backend storage container."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
