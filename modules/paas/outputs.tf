output "acr_id" {
  description = "The ID of the Container Registry."
  value = azurerm_container_registry.acr.id
}

output "kv_id" {
  description = "The ID of the Key Vault."
  value = azurerm_key_vault.kv.id
}
