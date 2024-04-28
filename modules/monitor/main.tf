resource "azurerm_log_analytics_workspace" "law" {
  name                       = var.log_analytics_workspace_name
  location                   = var.location
  resource_group_name        = var.resourcegroup_name
  sku                        = "PerGB2018"
  retention_in_days          = 30
  internet_ingestion_enabled = false
  internet_query_enabled     = true
  tags                       = var.tags
}

resource "azurerm_log_analytics_solution" "aks_solution" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resourcegroup_name
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}
resource "azurerm_application_insights" "appinsight" {
  name                = var.appinsight_name
  location            = var.location
  resource_group_name = var.resourcegroup_name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.law.id
  tags                = var.tags
}
