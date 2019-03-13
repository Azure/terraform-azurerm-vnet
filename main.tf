#Azure Generic vNet Module
resource "azurerm_resource_group" "vnet" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  location            = "${var.location}"
  address_space       = ["${var.address_space}"]
  resource_group_name = "${azurerm_resource_group.vnet.name}"
  dns_servers         = "${var.dns_servers}"
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "subnet" {
  count                     = "${length(var.subnets)}"
  name                      = "${lookup(var.subnets[count.index], "name")}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  resource_group_name       = "${azurerm_resource_group.vnet.name}"
  address_prefix            = "${lookup(var.subnets[count.index], "prefix")}"
  network_security_group_id = "${lookup(var.subnets[count.index], "nsg_id","")}"
}

#module "network_security_group" "nsg" {
#  source   = "../terraform-azurerm-network-security-group"
#  location = "${var.location}"
#}


#resource "azurerm_subnet_network_security_group_association" "nsg_association" {
#  count                     = "${length(var.subnets)}"
#  subnet_id                 = "${azurerm_subnet.subnet.*.id[count.index]}"
#  network_security_group_id = "${lookup(var.subnets[count.index], "nsg_id","")}"
#}

