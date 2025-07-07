variable "vnet_name" {
  description = "The name of the Azure Virtual Network (VNet)."
  type        = string
}

variable "address_space" {
  description = "The list of CIDR address spaces for the virtual network."
  type        = list(string)
}

variable "location" {
  description = "The Azure region where resources will be deployed, e.g., 'Central Europe'."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where resources will be created."
  type        = string
}

variable "app_subnet_name" {
  description = "The name of the subnet dedicated to the application."
  type        = string
}

variable "app_subnet_prefix" {
  description = "The CIDR address prefix for the application subnet."
  type        = string
}

variable "db_subnet_name" {
  description = "The name of the subnet dedicated to the database."
  type        = string
}

variable "db_subnet_prefix" {
  description = "The CIDR address prefix for the database subnet."
  type        = string
}