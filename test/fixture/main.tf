provider "azurerm" {
  features {}
}

resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  name     = "test-${random_id.rg_name.hex}-rg"
  location = var.location
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "test-${random_id.rg_name.hex}-nsg"
  resource_group_name = azurerm_resource_group.test.name
  location            = azurerm_resource_group.test.location
}

module "vnet" {
  source                   = "../../"
  resource_group_name      = azurerm_resource_group.test.name
  address_space            = ["10.0.0.0/16"]
  subnet_prefixes          = [["10.0.1.0/24"], ["10.0.2.0/24"], ["10.0.3.0/24"]]
  subnet_names             = ["subnet1", "subnet2", "subnet3"]
  subnet_service_endpoints = [["Microsoft.Sql"], [], []]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}



