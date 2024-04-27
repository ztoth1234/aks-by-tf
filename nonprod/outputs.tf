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
  value = module.paas.acr_id
}

output "kv_id" {
  description = "The ID of the Key Vault."
  value = module.paas.kv_id
}
