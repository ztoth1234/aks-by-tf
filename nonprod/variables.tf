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

variable "nsg_security_rules" {
  description = "NSGs with Security Rules"
  type = map(object({
    security_rules = list(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_port_range            = string
      source_port_ranges           = list(any)
      destination_port_range       = string
      destination_port_ranges      = list(any)
      source_address_prefix        = string
      source_address_prefixes      = list(any)
      destination_address_prefix   = string
      destination_address_prefixes = list(any)
    }))
  }))
  default = {
    nsg-bastion-nonprod-weu-01 = {
      security_rules = [
        {
          name                         = "allow-https-inbound"
          priority                     = 100
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "443"
          destination_port_ranges      = []
          source_address_prefix        = "Internet"
          source_address_prefixes      = []
          destination_address_prefix   = "*"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-gateway-manager-inbound"
          priority                     = 110
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "443"
          destination_port_ranges      = []
          source_address_prefix        = "GatewayManager"
          source_address_prefixes      = []
          destination_address_prefix   = "*"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-azure-loadbalancer-inbound"
          priority                     = 120
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "443"
          destination_port_ranges      = []
          source_address_prefix        = "AzureLoadBalancer"
          source_address_prefixes      = []
          destination_address_prefix   = "*"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-bastion-host-communication"
          priority                     = 130
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = ""
          destination_port_ranges      = [8080, 5701]
          source_address_prefix        = "VirtualNetwork"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-ssh-rdp-outbound"
          priority                     = 100
          direction                    = "Outbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = ""
          destination_port_ranges      = [22, 3389]
          source_address_prefix        = "*"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-azure-cloud-outbound"
          priority                     = 110
          direction                    = "Outbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "443"
          destination_port_ranges      = []
          source_address_prefix        = "*"
          source_address_prefixes      = []
          destination_address_prefix   = "AzureCloud"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-bastion-communication"
          priority                     = 120
          direction                    = "Outbound"
          access                       = "Allow"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = ""
          destination_port_ranges      = [8080, 5701]
          source_address_prefix        = "*"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-get-session-information"
          priority                     = 130
          direction                    = "Outbound"
          access                       = "Allow"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "80"
          destination_port_ranges      = []
          source_address_prefix        = "*"
          source_address_prefixes      = []
          destination_address_prefix   = "Internet"
          destination_address_prefixes = []
        },
        {
          name                         = "deny-vnet-vnet-traffic"
          priority                     = 4096
          direction                    = "Inbound"
          access                       = "Deny"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "*"
          destination_port_ranges      = []
          source_address_prefix        = "VirtualNetwork"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        }
      ]
    }
    nsg-agw-nonprod-weu-01 = {
      security_rules = [
        {
          name                         = "allow-agmanagement-subnet-traffic"
          priority                     = 100
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "65200-65535"
          destination_port_ranges      = []
          source_address_prefix        = "GatewayManager"
          source_address_prefixes      = []
          destination_address_prefix   = "*"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-azure-loadbalancer-inbound"
          priority                     = 110
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "*"
          destination_port_ranges      = []
          source_address_prefix        = "AzureLoadBalancer"
          source_address_prefixes      = []
          destination_address_prefix   = "*"
          destination_address_prefixes = []
        },
        {
          name                         = "allow-internet"
          priority                     = 120
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "443"
          destination_port_ranges      = []
          source_address_prefix        = "Internet"
          source_address_prefixes      = []
          destination_address_prefix   = "*"
          destination_address_prefixes = []
        },
        {
          name                         = "deny-vnet-vnet-traffic"
          priority                     = 4096
          direction                    = "Inbound"
          access                       = "Deny"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "*"
          destination_port_ranges      = []
          source_address_prefix        = "VirtualNetwork"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        }
      ]
    }
    nsg-jumpbox-nonprod-weu-01 = {
      security_rules = [
        {
          name                         = "allow-ssh-rdp-inbound"
          priority                     = 100
          direction                    = "Inbound"
          access                       = "Allow"
          protocol                     = "Tcp"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = ""
          destination_port_ranges      = [22, 3389]
          source_address_prefix        = "192.168.1.192/26"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        },
        {
          name                         = "deny-vnet-vnet-traffic"
          priority                     = 4096
          direction                    = "Inbound"
          access                       = "Deny"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "*"
          destination_port_ranges      = []
          source_address_prefix        = "VirtualNetwork"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        }
      ]
    }
    nsg-pe-nonprod-weu-01 = {
      security_rules = [
        {
          name                         = "deny-vnet-vnet-traffic"
          priority                     = 4096
          direction                    = "Inbound"
          access                       = "Deny"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "*"
          destination_port_ranges      = []
          source_address_prefix        = "VirtualNetwork"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        }
      ]
    }
    nsg-pivateagent-nonprod-weu-01 = {
      security_rules = [
        {
          name                         = "deny-vnet-vnet-traffic"
          priority                     = 4096
          direction                    = "Inbound"
          access                       = "Deny"
          protocol                     = "*"
          source_port_range            = "*"
          source_port_ranges           = []
          destination_port_range       = "*"
          destination_port_ranges      = []
          source_address_prefix        = "VirtualNetwork"
          source_address_prefixes      = []
          destination_address_prefix   = "VirtualNetwork"
          destination_address_prefixes = []
        }
      ]
    }
  }
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
  default = {
    rt-internet-default-nonprod-weu-01 = {
      routes = [
        {
          address_prefix         = "0.0.0.0/0"
          name                   = "default-route"
          next_hop_in_ip_address = ""
          next_hop_type          = "Internet"
        }
      ]
    }
    rt-aks-nonprod-weu-01 = {
      routes = [
        {
          address_prefix         = "0.0.0.0/0"
          name                   = "default-route"
          next_hop_in_ip_address = "192.168.1.4"
          next_hop_type          = "VirtualAppliance"
        }
      ]
    }
  }
}

variable "vnets" {
  description = "VNETs"
  type = map(object({
    vnet_name     = string
    address_space = list(string)
    subnets       = list(map(string))
  }))
  default = {
    vnet-hub-nonprod-weu-01 = {
      vnet_name     = "vnet-hub-nonprod-weu-01"
      address_space = ["192.168.1.0/24"]
      subnets = [
        {
          name           = "AzureFirewallSubnet"
          address_prefix = "192.168.1.0/26"
          nsg_name       = ""
          rt_name        = "rt-internet-default-nonprod-weu-01"
        },
        {
          name           = "AzureBastionSubnet"
          address_prefix = "192.168.1.192/26"
          nsg_name       = "nsg-bastion-nonprod-weu-01"
          rt_name        = ""
        }
      ]
    }
    vnet-spoke-nonprod-weu-01 = {
      vnet_name     = "vnet-spoke-nonprod-weu-01"
      address_space = ["10.1.0.0/21"]
      subnets = [
        {
          name           = "AwgSubnet"
          address_prefix = "10.1.4.32/27"
          nsg_name       = "nsg-agw-nonprod-weu-01"
          rt_name        = "rt-internet-default-nonprod-weu-01"
        },
        {
          name           = "AksSubnet"
          address_prefix = "10.1.0.0/23"
          nsg_name       = ""
          rt_name        = "rt-aks-nonprod-weu-01"
        },
        {
          name           = "JumpboxSubnet"
          address_prefix = "10.1.4.64/27"
          nsg_name       = "nsg-jumpbox-nonprod-weu-01"
          rt_name        = "rt-internet-default-nonprod-weu-01"
        },
        {
          name           = "LbSubnet"
          address_prefix = "10.1.4.0/27"
          nsg_name       = ""
          rt_name        = "rt-internet-default-nonprod-weu-01"
        },
        {
          name           = "PeSubnet"
          address_prefix = "10.1.4.128/27"
          nsg_name       = "nsg-pe-nonprod-weu-01"
          rt_name        = "rt-internet-default-nonprod-weu-01"
        },
        {
          name           = "PrivateBuildAgentSubnet"
          address_prefix = "10.1.4.96/27"
          nsg_name       = "nsg-pivateagent-nonprod-weu-01"
          rt_name        = "rt-internet-default-nonprod-weu-01"
        }
      ]
    }
  }
}

variable "public_ips" {
  description = "The name of the Public IP address resources."
  type        = list(string)
  default = [
    "pip-fw-nonprod-weu-01",
    "pip-agw-nonprod-weu-01",
    "pip-bastion-nonprod-weu-01"
  ]
}

variable "vnet_peerings" {
  description = "The name of the VNET peering resources."
  type        = list(string)
  default = [
    "peer-hub-spoke-nonprod-weu-01",
    "peer-spoke-hub-nonprod-weu-01"
  ]
}
