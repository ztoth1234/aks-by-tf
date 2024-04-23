locals {
  nsgs = toset(flatten([for nsgs in {for k, v in var.vnets : k => compact(v.subnets[*].nsg_name) } : nsgs]))
  rts  = toset(flatten([for rts in {for k, v in var.vnets : k => compact(v.subnets[*].rt_name) } : rts]))
}
resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
}

###############################################################
# Create NSGs, VNETs with subnets, public IPs, RTs, VNETpeers  #
###############################################################
module "network" {
  source             = "./modules/network"
  location_network   = var.resource_groups["rg1"].location
  resourcegroup_name = var.resource_groups["rg1"].name
  vnets              = var.vnets
  nsg_list           = local.nsgs
  rt_list            = local.rts
  public_ip_list     = var.public_ips
  vnet_peering_list  = var.vnet_peerings
  tags               = var.tags
}
