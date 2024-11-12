terraform {
  required_version = ">= 1.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.11, < 4.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.12.1, < 1.0"
    }
  }
}
