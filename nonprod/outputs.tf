output "resource_group_ids" {
  description = ""
  value = {
    for k, v in azurerm_resource_group.resource_groups : k => v.id
  }
}
