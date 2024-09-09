terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "az-wazuh-resources" {
  name     = "az-wazuh-resources"
  location = "East US"
  tags = {
    environment = "dev" #indiciates what environment your resources are deployed to
  }
}