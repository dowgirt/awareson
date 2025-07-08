variable "resource_group_name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  type        = string
  description = "Region"
}

variable "app_service_plan_name" {
  type        = string
  description = "App Service Plan name"
}

variable "app_service_name" {
  type        = string
  description = "App Service name"
}

variable "sku_name" {
  type        = string
  default     = "F1"
  description = "Pricing tier (e.g. F1 for Free)"
}

variable "os_type" {
  type        = string
  default     = "Linux"
  description = "Operating system: Linux or Windows"
}

variable "acr_identity_id" {
  type        = string
  default     = "Linux"
  description = "Operating system: Linux or Windows"
}

variable "app_settings" {
  description = "Application settings for the App Service"
  type        = map(string)
  default     = {}
}