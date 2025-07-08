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
  application_stack {
    docker_image_name        = var.docker_image_name           # np. "myapp:latest"
    docker_registry_url      = var.docker_registry_url         # np. "https://myacr.azurecr.io"
    docker_registry_username = var.docker_registry_username    # jeśli potrzebne (np. dla user/pass)
    docker_registry_password = var.docker_registry_password    # jeśli potrzebne
  }
}

  app_settings = var.app_settings
}