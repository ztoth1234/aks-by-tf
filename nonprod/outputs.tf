output "resource_group_ids" {
  description = "The IDs of the resource groups"
  value = {
    for k, v in azurerm_resource_group.resource_groups : k => v.id
  }
}

output "vnet_ids" {
  description = "The VNET IDs."
  value       = module.network.vnet_ids
}

output "subnet_ids" {
  description = "The IDs of the subnet within the VNETs"
  value       = module.network.subnet_ids
}

output "law_id" {
  description = "The Log Analytics Workspace ID."
  value       = module.monitor.law_id
}

output "app_id" {
  description = "The App ID associated with this Application Insights component."
  value       = module.monitor.app_id
}

output "acr_id" {
  description = "The ID of the Container Registry."
  value       = module.paas.acr_id
}

output "kv_id" {
  description = "The ID of the Key Vault."
  value       = module.paas.kv_id
}

output "aks_id" {
  description = "The Kubernetes Managed Cluster ID."
  value       = module.aks.aks_id
}

output "aks_client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = module.aks.aks_client_certificate
  sensitive   = true
}

output "aks_kube_config" {
  description = " Raw Kubernetes config to be used by kubectl and other compatible tools."
  value       = module.aks.aks_kube_config
  sensitive   = true
}

output "aks_private_fqdn" {
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value       = module.aks.aks_private_fqdn
}

output "aks_current_version" {
  description = "The current version running on the Azure Kubernetes Managed Cluster."
  value       = module.aks.aks_current_version
}
