terraform {
  backend "azurerm" {
    resource_group_name   = "awareson-dev-plc-rg"
    storage_account_name  = "awrsndevplctfsa"
    container_name        = "tfstate"
    key                   = "terraform-dev.tfstate"  # nazwa pliku stanu
  }
}