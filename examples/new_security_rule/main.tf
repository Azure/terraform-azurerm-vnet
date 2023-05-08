resource "random_id" "rg_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "example" {
  location = var.location
  name     = "test-${random_id.rg_name.hex}-rg"
}

module "vnet" {
  source = "../../"

  resource_group_name = azurerm_resource_group.example.name
  use_for_each        = var.use_for_each
  vnet_location       = var.location
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  nsg_ids = {
    subnet1 = azurerm_network_security_group.ssh.id
    subnet2 = azurerm_network_security_group.ssh.id
    subnet3 = azurerm_network_security_group.ssh.id
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

data "curl" "public_ip" {
  http_method = "GET"
  uri         = "https://api.ipify.org?format=json"
}

resource "azurerm_network_security_group" "ssh" {
  location            = azurerm_resource_group.example.location
  name                = "ssh"
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    access                     = "Allow"
    destination_address_prefix = "*"
    destination_port_range     = "22"
    direction                  = "Inbound"
    name                       = "test123"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = jsondecode(data.curl.public_ip.response).ip
    source_port_range          = "*"
  }
}