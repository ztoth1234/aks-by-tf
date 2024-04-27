output "client_certificate" {
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  description = " Raw Kubernetes config to be used by kubectl and other compatible tools."
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
