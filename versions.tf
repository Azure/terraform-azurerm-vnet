terraform {
  required_version = ">= 1.3.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    modtm = {
      source  = "Azure/modtm"
      version = "0.3.2"
    }
  }
}
