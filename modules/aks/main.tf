resource "azurerm_private_dns_zone" "aks_private_dns_zone" {
  name                = "privatelink.westeurope.azmk8s.io"
  resource_group_name = var.resourcegroup_name
}

resource "azurerm_user_assigned_identity" "aks_ui" {
  name                = "aks-user-identity"
  resource_group_name = var.resourcegroup_name
  location            = var.location
}

resource "azurerm_role_assignment" "aks-ui-role-assign" {
  scope                = azurerm_private_dns_zone.aks_private_dns_zone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_ui.principal_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.aks_name
  location                = var.location
  resource_group_name     = var.resourcegroup_name
  dns_prefix              = "aks"
  private_cluster_enabled = true
  private_dns_zone_id     = azurerm_private_dns_zone.aks_private_dns_zone.id
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_ui.id]
  }

  tags = var.tags
  depends_on = [
    azurerm_role_assignment.aks-ui-role-assign
  ]
}
