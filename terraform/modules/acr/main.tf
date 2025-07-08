resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}

resource "azurerm_user_assigned_identity" "acr_identity" {
  name                = "${var.acr_name}-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}