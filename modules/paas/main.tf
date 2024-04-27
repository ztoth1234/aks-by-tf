data "azurerm_client_config" "current" {}

resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  location                      = var.location
  resource_group_name           = var.resourcegroup_name
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  export_policy_enabled         = false
  anonymous_pull_enabled        = false
  data_endpoint_enabled         = true
  network_rule_bypass_option    = "AzureServices"
  tags                          = var.tags
}

#resource "azurerm_monitor_diagnostic_setting" "ds_acr" {
#  name                       = "ds-acr"
#  target_resource_id         = azurerm_container_registry.acr.id
#  log_analytics_workspace_id = var.law_id

#  enabled_log {
#    category = "ContainerRegistryLoginEvents"
#  }
#  enabled_log {
#    category = "ContainerRegistryRepositoryEvents"
#  }

#  metric {
#    category = "AllMetrics"
#  }
#  depends_on = [
#    azurerm_container_registry.acr
#  ]
#}

resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name =  var.resourcegroup_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_private_dns_zone_virtual_network_link" {
  name                  = "${var.acr_name}-private-dns-zone-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns_zone.name
  resource_group_name   = var.resourcegroup_name
  virtual_network_id    = var.pe_vnet_id
  tags                  = var.tags
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "${var.acr_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resourcegroup_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${var.acr_name}-service-connection"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.acr_name}-private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_private_dns_zone.id]
  }
}

resource "azurerm_key_vault" "kv" {
  name                            = var.kv_name
  location                        = var.location
  resource_group_name             = var.resourcegroup_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  sku_name                        = "standard"
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = true
  enable_rbac_authorization       = true
  public_network_access_enabled   = false
  network_acls {
    bypass = "AzureServices"
    default_action = "Deny"
  }
  tags                          = var.tags
}

resource "azurerm_private_dns_zone" "kv_private_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name =  var.resourcegroup_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "kv_private_dns_zone_virtual_network_link" {
  name                  = "${var.kv_name}-private-dns-zone-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.kv_private_dns_zone.name
  resource_group_name   = var.resourcegroup_name
  virtual_network_id    = var.pe_vnet_id
  tags                  = var.tags
}

resource "azurerm_private_endpoint" "kv_private_endpoint" {
  name                = "${var.kv_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resourcegroup_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${var.kv_name}-service-connection"
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.kv_name}-private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv_private_dns_zone.id]
  }
}
