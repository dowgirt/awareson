terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.35.0"
    }
  }

  required_version = ">= 1.12.2"
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "awareson-dev-plc-rg"
    storage_account_name = "awrsndevplctfsa"
    container_name       = "tfstate"
    key                  = "terraform-dev.tfstate"
  }
}