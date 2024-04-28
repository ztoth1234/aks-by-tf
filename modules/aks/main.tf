resource "azurerm_kubernetes_cluster" "aks" {
  name                       = var.aks_name
  location                   = var.location
  resource_group_name        = var.resourcegroup_name
  dns_prefix                 = "aks"
  private_cluster_enabled    = true
  kubernetes_version         = "1.28.5"
  oidc_issuer_enabled        = true
  workload_identity_enabled  = true
  run_command_enabled        = false
  local_account_disabled     = true
  azure_policy_enabled       = true

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  default_node_pool {
    name                         = "system"
    node_count                   = 2
    max_count                    = 5
    min_count                    = 2
    max_pods                     = 250
    vm_size                      = "Standard_D2_v2"
    os_disk_size_gb              = 30
    os_sku                       = "Ubuntu"
    type                         = "VirtualMachineScaleSets"
    orchestrator_version         = "1.28.5"
    only_critical_addons_enabled = true
    enable_node_public_ip        = false
    enable_auto_scaling          = true
    temporary_name_for_rotation  = "tmpsyspool"
    vnet_subnet_id               = var.system_node_subnet_id
    pod_subnet_id                = var.system_pod_subnet_id
    zones                        = ["1", "2"]
    tags = var.tags
  }
  #http_proxy_config {
  #  http_proxy = ""
  #  no_proxy = [var.system_node_subnet_id]
  #}

  api_server_access_profile {
    authorized_ip_ranges = []
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    service_cidr = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"
    ip_versions = ["IPv4"]
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
    #outbound_type     = "userDefinedRouting"
  }

  microsoft_defender {
   log_analytics_workspace_id = var.law_id
  }
  storage_profile {
    blob_driver_enabled         = true
    disk_driver_enabled         = false
    disk_driver_version         = null
    file_driver_enabled         = true
    snapshot_controller_enabled = false
  }
  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id      = var.law_id
    msi_auth_for_monitoring_enabled = true
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_user_pool" {
  name                  = "user"
  mode                  = "User"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 2
  max_count             = 5
  min_count             = 2
  max_pods              = 250
  os_disk_size_gb       = 30
  os_sku                = "Ubuntu"
  orchestrator_version  = "1.28.5"
  enable_node_public_ip = false
  enable_auto_scaling   = true
  vnet_subnet_id        = var.user_node_subnet_id
  pod_subnet_id         = var.user_pod_subnet_id
  zones                 = ["1", "2"]
  tags                  = var.tags
  lifecycle {
    ignore_changes = [ node_count ]
  }
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

resource "azurerm_role_assignment" "attach_aks_to_acr" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = var.acr_id
  skip_service_principal_aad_check = true
}
