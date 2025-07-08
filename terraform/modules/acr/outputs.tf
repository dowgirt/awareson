output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "Login server for ACR (e.g., myregistry.azurecr.io)"
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "ACR resource ID"
}

output "managed_identity_id" {
  value       = azurerm_user_assigned_identity.acr_identity.id
  description = "User Assigned Managed Identity ID"
}

output "managed_identity_id" {
  value       = azurerm_user_assigned_identity.acr_identity.id
  description = "ID of the managed identity"
}

output "managed_identity_client_id" {
  value       = azurerm_user_assigned_identity.acr_identity.client_id
  description = "Client ID of the managed identity"
}

output "managed_identity_principal_id" {
  value       = azurerm_user_assigned_identity.acr_identity.principal_id
  description = "Principal ID of the managed identity"
}