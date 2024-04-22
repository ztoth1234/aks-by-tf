resource "azurerm_resource_group" "testrg" {
  name     = "rg-test"
  location = var.location
}
