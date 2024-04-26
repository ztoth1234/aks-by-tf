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
    retention_policy {
      enabled = false
    }
  }

  enabled_log {
    category = "ContainerRegistryRepositoryEvents"
    retention_policy {
      enabled = false
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }
}