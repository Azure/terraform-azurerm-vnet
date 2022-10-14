# 3.0.0 (Oct 8th, 2022)

ENHANCEMENTS:

* Add new output `vnet_subnets_name_id`. [#55](https://github.com/Azure/terraform-azurerm-vnet/pull/55)
* Add new CI pipeline. [#71](https://github.com/Azure/terraform-azurerm-vnet/pull/71)
* Remove `data.azurerm_resource_group.vnet`. [#72](https://github.com/Azure/terraform-azurerm-vnet/pull/72)
* `var.subnet_prefixes`'s default value now is `["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]`. [#73](https://github.com/Azure/terraform-azurerm-vnet/pull/73)

BUG FIXES:
