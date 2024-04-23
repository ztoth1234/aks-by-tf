output "resource_group_ids" {
  description = ""
  value = {
    for k, v in var.resource_groups : k => v.id
  }
}
