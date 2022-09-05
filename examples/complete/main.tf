resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "test" {
  location = var.location
  name     = "test-${random_id.rg_name.hex}-rg"
}

resource "azurerm_network_security_group" "nsg1" {
  location            = var.vnet_location
  name                = "test-${random_id.rg_name.hex}-nsg"
  resource_group_name = azurerm_resource_group.test.name
}

resource "azurerm_route_table" "rt1" {
  location            = var.vnet_location
  name                = "test-${random_id.rg_name.hex}-rt"
  resource_group_name = azurerm_resource_group.test.name
}

module "vnet" {
  source = "../../"

  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
  nsg_ids = {
    subnet1 = azurerm_network_security_group.nsg1.id
  }
  route_tables_ids = {
    subnet1 = azurerm_route_table.rt1.id
  }
  subnet_delegation = {
    subnet2 = {
      "Microsoft.Sql.managedInstances" = {
        service_name = "Microsoft.Sql/managedInstances"
        service_actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      }
    }
  }
  subnet_enforce_private_link_endpoint_network_policies = {
    subnet2 = true
  }
  subnet_enforce_private_link_service_network_policies = {
    subnet3 = true
  }
  subnet_names    = ["subnet1", "subnet2", "subnet3"]
  subnet_prefixes = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
  vnet_location = var.vnet_location
  vnet_name     = "vnet-${random_id.rg_name.hex}"

  depends_on = [azurerm_resource_group.test]
}



