variable "acr_name" {
  type        = string
  description = "Globally unique name for the Azure Container Registry"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "ACR SKU (Basic, Standard, Premium)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to resources"
}