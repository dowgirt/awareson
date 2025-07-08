output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Login server for ACR (e.g., myregistry.azurecr.io)"
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "ACR resource ID"
}