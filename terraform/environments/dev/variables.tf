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

  docker_image_name   = "myapp-1b6a589"
  docker_registry_url = "https://${module.acr.acr_login_server}"

  app_settings = {
    DB_SERVER                           = "${module.sql_server_databases.sql_server_fqdn}"
    DB_NAME                             = "db1"
    DB_USER                             = "admin${random_integer.sql_admin_suffix.result}"
    DB_PASSWORD                         = "${random_password.sql_admin_password.result}"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    WEBSITES_PORT                       = "8080"
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
  description = "Address space for the Virtual Network (VNet)"
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

variable "databases" {
  description = "List or map of database configurations"
  type        = any
}

variable "app_service_sku_name" {
  description = "SKU name for the App Service plan"
  type        = string
}

variable "acr_sku" {
  description = "SKU name for the ACR"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}