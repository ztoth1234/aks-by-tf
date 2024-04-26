resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
}

###############################################################
# Create NSGs, RTs, VNETs with subnets, public IPs, VNETpeers #
###############################################################
module "network" {
  source             = "../modules/network"
  location_network   = var.resource_groups["rg1"].location
  resourcegroup_name = var.resource_groups["rg1"].name
  vnets              = var.vnets
  nsg_security_rules = var.nsg_security_rules
  rt_routes          = var.rt_routes
  public_ip_list     = var.public_ips
  vnet_peering_list  = var.vnet_peerings
  tags               = var.tags
  depends_on = [
    azurerm_resource_group.resource_groups
  ]
}

module "monitor" {
  source                       = "../modules/monitor"
  location                     = var.resource_groups["rg2"].location
  resourcegroup_name           = var.resource_groups["rg2"].name
  log_analytics_workspace_name = var.log_analytics_workspace_name
  appinsight_name              = var.appinsight_name
  tags                         = var.tags
  depends_on = [
    azurerm_resource_group.resource_groups
  ]
}

module "paas" {
  source             = "../modules/paas"
  location           = var.resource_groups["rg3"].location
  resourcegroup_name = var.resource_groups["rg3"].name
  acr_name           = var.acr_name
  law_id             = module.monitor.law_id
  acr_pe_vnet_id     = [for v in { for k, v in module.network.vnet_ids : k => v if strcontains(v, "spoke") } : v][0]
  acr_pe_subnet_id   = [for v in flatten([for v in module.network.subnet_ids : v]) : v if strcontains(v, "PeSubnet")][0]
  tags               = var.tags
  depends_on = [
    azurerm_resource_group.resource_groups,
    module.network,
    module.monitor
  ]
}
