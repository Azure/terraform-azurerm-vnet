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
  location            = var.vnet_location
}

resource "azurerm_route_table" "rt1" {
  name                = "test-${random_id.rg_name.hex}-rt"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.vnet_location
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = "test-${random_id.rg_name.hex}-hub-vnet"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.vnet_location
  address_space       = ["11.0.0.0/16"]
}

resource "azurerm_virtual_network" "spoke_vnet" {
  name                = "test-${random_id.rg_name.hex}-spoke-vnet"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.vnet_location
  address_space       = ["12.0.0.0/16"]
}

module "hub_vnet" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
  vnet_location       = var.vnet_location
  vnet_peer_ids       = [azurerm_virtual_network.hub_vnet.id, azurerm_virtual_network.spoke_vnet.id]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  route_tables_ids = {
    subnet1 = azurerm_route_table.rt1.id
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  subnet_enforce_private_link_endpoint_network_policies = {
    subnet2 = true
  }

  subnet_enforce_private_link_service_network_policies = {
    subnet3 = true
  }

  depends_on = [azurerm_resource_group.test]
}

module "spoke_vnet" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["11.0.0.0/16"]
  subnet_prefixes     = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
  vnet_location       = var.vnet_location
  vnet_peer_ids       = [azurerm_virtual_network.hub_vnet.id, azurerm_virtual_network.spoke_vnet.id]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  route_tables_ids = {
    subnet1 = azurerm_route_table.rt1.id
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  subnet_enforce_private_link_endpoint_network_policies = {
    subnet2 = true
  }

  subnet_enforce_private_link_service_network_policies = {
    subnet3 = true
  }

  depends_on = [azurerm_resource_group.test]
}

