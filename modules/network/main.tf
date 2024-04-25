resource "azurerm_network_security_group" "nsgs" {
  for_each            = var.nsg_security_rules
  name                = each.key
  location            = var.location_network
  resource_group_name = var.resourcegroup_name

  dynamic security_rule {
    for_each = flatten(each.value.security_rules)
    content {
      name                         = security_rule.value.name
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol
      source_port_range            = security_rule.value.source_port_range
      source_port_ranges           = security_rule.value.source_port_ranges
      destination_port_range       = security_rule.value.destination_port_range
      destination_port_ranges      = security_rule.value.destination_port_ranges
      source_address_prefix        = security_rule.value.source_address_prefix
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefix   = security_rule.value.destination_address_prefix
      destination_address_prefixes = security_rule.value.destination_address_prefixes
    }
  }
}

resource "azurerm_route_table" "rts" {
  for_each            = var.rt_routes
  name                = each.key
  location            = var.location_network
  resource_group_name = var.resourcegroup_name

  dynamic route {
    for_each = flatten(each.value.routes)
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address != "" ? route.value.next_hop_in_ip_address : null
    }
  }
}

resource "azurerm_virtual_network" "vnets" {
  for_each            = var.vnets
  name                = each.value.vnet_name
  location            = var.location_network
  resource_group_name = var.resourcegroup_name
  address_space       = each.value.address_space

  dynamic subnet {
    for_each = flatten(each.value.subnets)
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.address_prefix
      security_group = subnet.value.nsg_name != "" ? azurerm_network_security_group.nsgs[subnet.value.nsg_name].id : null
    }
  }
  tags = var.tags
  depends_on = [
    azurerm_network_security_group.nsgs,
    azurerm_route_table.rts
  ]
}

resource "azurerm_subnet_route_table_association" "rt_to_hub_subnets" {
  for_each = {for k, v in flatten(var.vnets[[for vn in var.vnets : vn.vnet_name][0]].subnets) : k => v if v.rt_name != ""}
  subnet_id      = azurerm_virtual_network.vnets[[for vn in var.vnets : vn.vnet_name][0]].subnet.*.id[each.key]
  route_table_id = azurerm_route_table.rts[each.value.rt_name].id
}

resource "azurerm_subnet_route_table_association" "rt_to_spoke_subnets" {
  for_each = {for k, v in flatten(var.vnets[[for vn in var.vnets : vn.vnet_name][1]].subnets) : k => v if v.rt_name != ""}
  subnet_id      = azurerm_virtual_network.vnets[[for vn in var.vnets : vn.vnet_name][1]].subnet.*.id[each.key]
  route_table_id = azurerm_route_table.rts[each.value.rt_name].id
}
