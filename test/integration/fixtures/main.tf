module "network" {
  source              = "../../../"
  resource_group_name = "${random_id.rg_name.hex}"
  location            = "eastus"
  address_space       = "10.0.0.0/16"
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  nsg_ids = {
    subnet1 = "${azurerm_network_security_group.nsg1.id}"
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

resource "random_id" "rg_name" {
  byte_length = 8
}

//Create a resource group and nsg to use for testing nsg association.
resource "azurerm_resource_group" "myapp2" {
  name     = "${random_id.rg_name.hex}"
  location = "eastus"
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "nsg1"
  resource_group_name = "${azurerm_resource_group.myapp2.name}"
  location            = "${azurerm_resource_group.myapp2.location}"
}
