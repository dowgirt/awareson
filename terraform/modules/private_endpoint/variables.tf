variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "private_connection_resource_id" {}
variable "sql_server_name" {}
variable "vnet_id" {}
variable "tags" {
  type    = map(string)
  default = {}
}