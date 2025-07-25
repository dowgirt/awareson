output "identity_principal_id" {
  description = "Principal ID of the user-assigned identity used by the App Service"
  value       = azurerm_linux_web_app.web_app.identity[0].principal_id
}

output "app_service_id" {
  value = azurerm_linux_web_app.web_app.id
}