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

variable "linux_fx_version" {
  description = "Runtime stack version (e.g., NODE|18-lts, PYTHON|3.11)"
  type        = string
}

variable "app_settings" {
  description = "App settings for the App Service"
  type        = map(string)
  default     = {}
}