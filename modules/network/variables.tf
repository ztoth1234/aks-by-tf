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

variable "nsg_list" {
  description = "The names of the NSG resources."
  type        = list(string)
}

variable "rt_list" {
  description = "The names of the RT resources."
  type        = list(string)
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