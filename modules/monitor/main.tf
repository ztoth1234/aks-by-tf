resource "azurerm_log_analytics_workspace" "law" {
  name                       = var.log_analytics_workspace_name
  location                   = var.location
  resource_group_name        = var.resourcegroup_name
  sku                        = "PerGB2018"
  retention_in_days          = 30
  internet_ingestion_enabled = false
  internet_query_enabled     = false
  tags                       = var.tags
}

resource "azurerm_application_insights" "appinsight" {
  name                = var.appinsight_name
  location            = var.location
  resource_group_name = var.resourcegroup_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.law.id
  tags                = var.tags
}
