variable "resource_group_name" {}
variable "location" {}
variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "sku_name" {}
variable "os_type" {}
variable "acr_identity_id" {}
variable "docker_image_name" {}
variable "docker_registry_url" {}
variable "docker_registry_username" {}
variable "docker_registry_password" {}
variable "tags" {}
variable "app_settings" {
  type = map(string)
}
variable "site_config" {
  type = map(string)
}
