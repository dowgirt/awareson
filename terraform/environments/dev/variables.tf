locals {
  resources_suffix        = "${var.project}-${var.environment}"
  vnet_name               = "vnet-${local.resources_suffix}"
  app_subnet_name         = "sub-app-${local.resources_suffix}"
  db_subnet_name          = "sub-db-${local.resources_suffix}"
  app_service_plan_name   = "plan-${local.resources_suffix}"
  app_service_name        = "app-${local.resources_suffix}"
  sql_server_name           = "sql-${local.resources_suffix}"
  key_vault_name            = "kv-${local.resources_suffix}"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
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

variable "tags" {}