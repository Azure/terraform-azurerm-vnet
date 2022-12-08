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
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]
  route_tables_ids = {
    subnet1 = azurerm_route_table.example.id
    subnet2 = azurerm_route_table.example.id
    subnet3 = azurerm_route_table.example.id
  }
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

resource "azurerm_route_table" "example" {
  location            = azurerm_resource_group.example.location
  name                = "MyRouteTable"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_route" "example" {
  address_prefix      = "10.1.0.0/16"
  name                = "acceptanceTestRoute1"
  next_hop_type       = "VnetLocal"
  resource_group_name = azurerm_resource_group.example.name
  route_table_name    = azurerm_route_table.example.name
}