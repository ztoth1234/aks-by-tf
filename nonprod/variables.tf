variable "location" {
  description = "The location/region where the resource is created."
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default = {
    "ApplicationID"       = "AP000000000"
    "ApplicationName"     = "ZT Lab PoC"
    "Environment"         = "NonProd"
    "GitHubRepoReference" = "https://github.com/ztoth1234/aks-by-tf"
  }
}

variable "resource_groups" {
  description = "Resource groups"
  type = map(object({
    name     = string
    location = string
  }))
  default = {
    rg1 = {
      name     = "rg-aks-network-nonprod-weu-01"
      location = "westeurope"
    }
    rg2 = {
      name     = "rg-aks-monitor-nonprod-weu-01"
      location = "westeurope"
    }
    rg3 = {
      name     = "rg-aks-paas-nonprod-weu-01"
      location = "westeurope"
    }
    rg4 = {
      name     = "rg-aks-cluster-nonprod-weu-01"
      location = "westeurope"
    }
    rg5 = {
      name     = "rg-aks-remote-nonprod-weu-01",
      location = "westeurope"
    }
  }
}

variable "vnets" {
  description = "VNETs"
  type = map(object({
    address_space = list(string)
    subnets       = list(map(string))
  }))
  default = {
    vnet-hub-nonprod-weu-01 = {
      address_space = ["192.168.1.0/24"]
      subnets = [
      {
        name     = "AzureFirewallSubnet"
        address_prefix = "192.168.1.0/26"
        nsg_name = ""
        rt_name  = "rt-internet-default-nonprod-weu-01"
      },
      {
        name     = "AzureBastionSubnet"
        address_prefix = "192.168.1.192/26"
        nsg_name = "nsg-bastion-nonprod-weu-01"
        rt_name  = "rt-internet-default-nonprod-weu-01"
      }
      ]
    }
    vnet-spoke-nonprod-weu-01 = {
      address_space = ["10.1.0.0/21"]
      subnets = [
      {
        name     = "AwgSubnet"
        address_prefix = "10.1.4.32/27"
        nsg_name = "nsg-agw-nonprod-weu-01"
        rt_name  = "rt-internet-default-nonprod-weu-01"
      },
      {
        name     = "AksSubnet"
        address_prefix = "10.1.1.0/23"
        nsg_name = ""
        rt_name  = "rt-aks-nonprod-weu-01"
      },
      {
        name     = "JumpboxSubnet"
        address_prefix = "10.1.4.64/27"
        nsg_name = "nsg-jumpbox-nonprod-weu-01"
        rt_name  = "rt-internet-default-nonprod-weu-01"
      },
      {
        name     = "LbSubnet"
        address_prefix = "10.1.4.0/27"
        nsg_name = ""
        rt_name  = "rt-internet-default-nonprod-weu-01"
      },
      {
        name     = "PeSubnet"
        address_prefix = "10.1.4.128/27"
        nsg_name = "nsg-pe-nonprod-weu-01"
        rt_name  = "rt-internet-default-nonprod-weu-01"
      },
      {
        name     = "PrivateBuildAgentSubnet"
        address_prefix = "10.1.4.96/27"
        nsg_name = "nsg-pivateagent-nonprod-weu-01"
        rt_name  = "rt-internet-default-nonprod-weu-01"
      }
      ]
    }
  }
}

variable "public_ips" {
  description = "The name of the Public IP address resources."
  type        = list(string)
  default     = [
    pip-fw-nonprod-weu-01,
    pip-agw-nonprod-weu-01,
    pip-bastion-nonprod-weu-01
  ]
}

variable "vnet_peerings" {
  description = "The name of the VNET peering resources."
  type        = list(string)
  default     = [
    peer-hub-spoke-nonprod-weu-01,
    peer-spoke-hub-nonprod-weu-01
  ]
}
