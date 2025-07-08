locals {
  resources_suffix          = "${var.project}-${var.environment}"
  vnet_name                 = "vnet-${local.resources_suffix}"
  app_subnet_name           = "sub-app-${local.resources_suffix}"
  db_subnet_name            = "sub-db-${local.resources_suffix}"
  app_service_plan_name     = "plan-${local.resources_suffix}"
  app_service_name          = "app-${local.resources_suffix}"
  sql_server_name           = "sql-${local.resources_suffix}"
  key_vault_name            = "kv-${local.resources_suffix}"
  sql_private_endpoint_name = "pep-${local.resources_suffix}"
  acr_name                  = "acr${var.project}${var.environment}"

  docker_image_name        = "1234"  
  docker_registry_url      = "${module.acr.acr_login_server}"
  docker_registry_username = "${module.acr.acr_admin_username}"
  docker_registry_password = "${module.acr.acr_admin_password}"

  app_settings = {
    DB_HOST                             = "${module.sql_server_databases.sql_server_fqdn}"
    DB_NAME                             = "db1"
    DB_USER                             = "admin${random_integer.sql_admin_suffix.result}"
    DB_PASSWORD                         = "${random_password.sql_admin_password.result}"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}
variable "project" {
  description = "Project or company name"
  type        = string
}
variable "environment" {
  description = "Deployment environment"
  type        = string
}
variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}
variable "app_subnet_prefix" {
  description = "CIDR block for the application subnet"
  type        = string
}
variable "db_subnet_prefix" {
  description = "CIDR block for the database subnet"
  type        = string
}
variable "databases" {}
variable "tags" {}
variable "app_service_sku_name" {}