data "azurerm_resource_group" "rg" {
  name = "awareson-dev-plc-rg"
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
  sku_name              = "F1" # najtańsza opcja
  linux_fx_version      = "DOTNETCORE|6.0"
}