locals {
  vnet_name       = "${var.project}-${var.environment}-${var.region_code}-vnet"
  app_subnet_name = "${var.project}-${var.environment}-${var.region_code}-sub-app"
  db_subnet_name  = "${var.project}-${var.environment}-${var.region_code}-sub-db"

  app_service_plan_name = "${var.project}-${var.environment}-${var.region_code}-plan"
  app_service_name      = "${var.project}-${var.environment}-${var.region_code}-app"
}