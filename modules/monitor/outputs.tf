output "law_id" {
  description = "The Log Analytics Workspace ID."
  value = azurerm_log_analytics_workspace.law.id
}
output "app_id" {
  description = "The App ID associated with this Application Insights component."
  value = azurerm_application_insights.appinsight.app_id
}
