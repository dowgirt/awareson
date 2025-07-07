output "sql_server_id" {
  description = "The ID of the created Sql Server"
  value       = azurerm_mssql_server.mssql_server.id
}
output "sql_server_fqdn" {
  description = "The Fully Qualified Domain Name of the created Sql Server"
  value       = azurerm_mssql_server.mssql_server.fully_qualified_domain_name
}