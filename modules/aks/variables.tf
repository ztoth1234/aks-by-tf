variable "aks_name" {
  description = "Specifies the name of the Azure Kubernetes Cluster."
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

variable "acr_id" {
  description = "The ID of the Container Registry."
  type = string
}

variable "law_id" {
  description = "The Log Analytics Workspace ID."
  type        = string
}

variable "system_node_subnet_id" {
  description = "The subnet ID of the System Node subnet of the AKS"
  type = string
}

variable "system_pod_subnet_id" {
  description = "The subnet ID of the System Pod subnet of the AKS"
  type = string
}

variable "user_node_subnet_id" {
  description = "The subnet ID of the User Node subnet of the AKS"
  type = string
}

variable "user_pod_subnet_id" {
  description = "The subnet ID of the User Pod subnet of the AKS"
  type = string
}
