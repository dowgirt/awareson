output "private_endpoint_ip" {
  value = azurerm_private_endpoint.sql_pe.private_service_connection[0].private_ip_address
}