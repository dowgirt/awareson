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
  source              = "../../modules/key-vault"
  kv_name             = local.key_vault_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  object_id           = data.azurerm_client_config.current.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = var.tags
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
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  sql_server_name           = local.sql_server_name
  sql_server_admin_password = random_password.sql_admin_password.result
  sql_server_admin_username = "admin${random_integer.sql_admin_suffix.result}"
  databases                 = var.databases
  tags                      = var.tags
}

module "sql_private_endpoint" {
  source = "../../modules/private_endpoint"

  name                           = local.sql_private_endpoint_name
  resource_group_name            = data.azurerm_resource_group.rg.name
  location                       = data.azurerm_resource_group.rg.location
  subnet_id                      = module.network.app_subnet_id
  private_connection_resource_id = module.sql_server_databases.sql_server_id
  sql_server_name                = module.sql_server_databases.sql_server_name
  vnet_id                        = module.network.vnet_id
  tags                           = var.tags
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  vnet_name           = local.vnet_name
  address_space       = var.address_space
  app_subnet_name     = local.app_subnet_name
  app_subnet_prefix   = var.app_subnet_prefix
  db_subnet_name      = local.db_subnet_name
  db_subnet_prefix    = var.db_subnet_prefix
}

module "acr" {
  source                   = "../../modules/acr"
  acr_name                 = local.acr_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  tags                     = var.tags
  app_service_principal_id = module.app_service.app_service_principal_id
  
}

module "app_service" {
  source                = "../../modules/app_service"
  resource_group_name   = data.azurerm_resource_group.rg.name
  location              = data.azurerm_resource_group.rg.location
  app_service_plan_name = local.app_service_plan_name
  app_service_name      = local.app_service_name
  sku_name              = var.app_service_sku_name
  acr_identity_id       = module.acr.managed_identity_id
  app_settings          = local.app_settings
  docker_image_name     = local.docker_image_name
  docker_registry_url   = local.docker_registry_url

}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = module.acr.acr_id
  role_definition_name = "AcrPull"
  principal_id         = module.app_service.identity_principal_id
}




