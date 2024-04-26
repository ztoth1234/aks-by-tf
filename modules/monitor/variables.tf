variable "log_analytics_workspace_name" {
  description = "Specifies the name of the Log Analytics Workspace."
  type        = string
}
variable "appinsight_name" {
  description = "Specifies the name of the Application Insights component."
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
