resource "azurerm_service_plan" "app_plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "web_app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app_plan.id

identity {
    type         = "UserAssigned"
    identity_ids = [var.acr_identity_id]
  }

  site_config {
  }
}