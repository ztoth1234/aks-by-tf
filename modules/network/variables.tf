variable "location_network" {
  description = "The location of the network related resources."
  type        = string
}

variable "resourcegroup_name" {
  description = "The name of the Resource Group."
  type        = string
}

variable "vnets" {
  description = "VNETs"
  type = map(object({
    address_space = list(string)
    subnets       = list(map(string))
  }))
}

variable "nsg_security_rules" {
  description = "NSGs with Security Rules"
  type = map(object({
    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "rt_routes" {
  description = "RTs with Routes"
  type = map(object({
    routes = list(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))
  }))
}

variable "public_ip_list" {
  description = "The names of the public IP resources."
  type        = list(string)
}

variable "vnet_peering_list" {
  description = "The names of the VNET peering resources."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
}