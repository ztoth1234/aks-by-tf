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

resource "azurerm_monitor_diagnostic_setting" "ds_acr" {
  name                       = "ds-acr"
  target_resource_id         = azurerm_container_registry.acr.id
  log_analytics_workspace_id = var.law_id

  enabled_log {
    category = "ContainerRegistryLoginEvents"
  }
  enabled_log {
    category = "ContainerRegistryRepositoryEvents"
  }

  metric {
    category = "AllMetrics"
  }
}

resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name =  var.resourcegroup_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_private_dns_zone_virtual_network_link" {
  name                  = "${var.acr_name}-private-dns-zone-vnet-link"
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns_zone.name
  resource_group_name   = var.resourcegroup_name
  virtual_network_id    = var.acr_pe_vnet_id
  tags                  = var.tags
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "${var.acr_name}-private-endpoint"
  location            = var.location
  resource_group_name = var.resourcegroup_name
  subnet_id           = var.acr_pe_subnet_id

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
