resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "test-${random_id.rg_name.hex}-rg"
}

module "vnet" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.example.name
  use_for_each        = var.use_for_each
  vnet_location       = var.location
  enable_telemetry    = false
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  subnet_enforce_private_link_service_network_policies = {
    "subnet3" = true
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}