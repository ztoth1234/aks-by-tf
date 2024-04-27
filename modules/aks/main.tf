resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.aks_name
  location                = var.location
  resource_group_name     = var.resourcegroup_name
  dns_prefix              = "aks"
  private_cluster_enabled = true
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "attach_aks_to_acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}
