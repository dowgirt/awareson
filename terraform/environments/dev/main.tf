data "azurerm_resource_group" "rg" {
  name = "awareson-dev-plc-rg"
}

module "network" {
  source              = "../../modules/network"
  resource_group_name = data.azurerm_resource_group.rg.name
  vnet_name           = local.vnet_name
  address_space       = var.address_space
  location            = var.location
  app_subnet_name     = local.app_subnet_name
  app_subnet_prefix   = var.app_subnet_prefix
  db_subnet_name      = local.db_subnet_name
  db_subnet_prefix    = var.db_subnet_prefix
}