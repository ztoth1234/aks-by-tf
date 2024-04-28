output "aks_id" {
  description = "The Kubernetes Managed Cluster ID."
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "aks_kube_config" {
  description = " Raw Kubernetes config to be used by kubectl and other compatible tools."
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_private_fqdn" {
  description = "The FQDN for the Kubernetes Cluster when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value = azurerm_kubernetes_cluster.aks.private_fqdn
}

output "aks_current_version" {
  description = "The current version running on the Azure Kubernetes Managed Cluster."
  value = azurerm_kubernetes_cluster.aks.kubernetes_version
}
