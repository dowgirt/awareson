resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  minimum_tls_version          = "1.2"
  administrator_login          = var.sql_server_admin_username
  administrator_login_password = var.sql_server_admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "db" {
  for_each             = var.databases
  server_id            = azurerm_mssql_server.mssql_server.id
  name                 = each.key
  max_size_gb          = each.value.max_size_gb
  sku_name             = each.value.sku_name
  zone_redundant       = each.value.zone_redundant
  storage_account_type = each.value.storage_account_type

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "mssql_server_rule" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.mssql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}