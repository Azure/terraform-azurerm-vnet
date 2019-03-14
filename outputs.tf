output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.id}"
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.name}"
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.location}"
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.address_space}"
}

output "vnet_subnet_ids" {
  description = "The ids of subnets created inside the newl vNet"
  value       = "${zipmap(azurerm_subnet.subnet.*.name, azurerm_subnet.subnet.*.id)}"
}

output "vnet_subnet_prefixes" {
  description = "The address spaces of the subnets"
  value       = "${zipmap(azurerm_subnet.subnet.*.name, azurerm_subnet.subnet.*.address_prefix)}"
}
