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
variable "region_code" {
  description = "Region code abbreviation"
  type        = string
}
variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "app_subnet_name" {
  description = "Name of the application subnet"
  type        = string
}

variable "app_subnet_prefix" {
  description = "CIDR block for the application subnet"
  type        = string
}

variable "db_subnet_name" {
  description = "Name of the database subnet"
  type        = string
}

variable "db_subnet_prefix" {
  description = "CIDR block for the database subnet"
  type        = string
}