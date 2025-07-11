terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
  subscription_id = "289da116-5358-4835-8897-9e1db2cde3d2"
}