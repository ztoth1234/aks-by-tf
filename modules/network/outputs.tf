output "vnet_ids" {
  description = "The VNET IDs."
  value = {
    for k, v in azurerm_virtual_network.vnets : k => v.id
  }
}

output "subnet_ids" {
  description = "The IDs of the subnet within the VNETs"
  value = {
    for k, v in azurerm_virtual_network.vnets : k => v.subnet.*.id
  }
}
