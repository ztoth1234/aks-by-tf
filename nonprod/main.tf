resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
}

###############################################################
# Create NSGs, RTs, VNETs with subnets, public IPs, VNETpeers #
###############################################################
module "network" {
  source             = "./modules/network"
  location_network   = var.resource_groups["rg1"].location
  resourcegroup_name = var.resource_groups["rg1"].name
  vnets              = var.vnets
  nsg_security_rules = var.nsg_security_rules
  rt_routes          = var.rt_routes
  public_ip_list     = var.public_ips
  vnet_peering_list  = var.vnet_peerings
  tags               = var.tags
}
