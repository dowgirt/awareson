data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = "awareson-dev-plc-rg"
}

resource "random_password" "sql_admin_password" {
  length      = 20
  min_lower   = 5
  min_upper   = 5
  min_numeric = 5
  special     = false
}
resource "random_integer" "sql_admin_suffix" {
  max  = 9999
  min  = 1000
  seed = "admin"
}

module "key_vault" {
  source         = "../../modules/key-vault"
  kv_name        = local.key_vault_name
  resource_group = data.azurerm_resource_group.rg.name
  object_id      = data.azurerm_client_config.current.object_id
  tenant_id      = data.azurerm_client_config.current.tenant_id
  tags           = var.tags
}

module "sql_server_secrets" {
  source = "../../modules/key-vault-secret"
  kv_id  = module.key_vault.kv_id
  secrets = {
    "sql-server-admin-password" = "${random_password.sql_admin_password.result}",
    "sql-server-admin-username" = "admin${random_integer.sql_admin_suffix.result}"
  }
}

module "sql_server_databases" {
  source                    = "../../modules/sql-server-and-database"
  resource_group            = data.azurerm_resource_group.rg.name
  sql_server_name           = local.sql_server_name
  sql_server_admin_password = random_password.sql_admin_password.result
  sql_server_admin_username = "admin${random_integer.sql_admin_suffix.result}"
  databases                 = var.databases
  tags                      = var.tags
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = local.vnet_name
  address_space       = var.address_space
  app_subnet_name     = local.app_subnet_name
  app_subnet_prefix   = var.app_subnet_prefix
  db_subnet_name      = local.db_subnet_name
  db_subnet_prefix    = var.db_subnet_prefix
}

module "app_service" {
  source                = "../../modules/app_service"
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = var.location
  app_service_plan_name = local.app_service_plan_name
  app_service_name      = local.app_service_name
  sku_name              = "B1"
}