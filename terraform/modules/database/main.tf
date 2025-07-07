resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group.name
  location                     = var.resource_group.location
  version                      = "12.0"
  minimum_tls_version          = "1.2"
  administrator_login          = var.sql_server_admin_username
  administrator_login_password = var.sql_server_admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "db" {
  for_each       = var.databases
  server_id      = azurerm_mssql_server.mssql_server.id
  name           = each.key
  max_size_gb    = each.value.max_size_gb
  sku_name       = each.value.sku_name
  zone_redundant = each.value.zone_redundant

  tags = var.tags
}