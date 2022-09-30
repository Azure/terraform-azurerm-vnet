# terraform-azurerm-vnet

[![Build Status](https://travis-ci.org/Azure/terraform-azurerm-vnet.svg?branch=master)](https://travis-ci.org/Azure/terraform-azurerm-vnet)

## Create a basic virtual network in Azure

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.

The module does not create nor expose a security group. This would need to be defined separately as additional security rules on subnets in the deployed network.

## Usage in Terraform 0.13

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.example]
}
```

## Usage in Terraform 0.12

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  vnet_location       = "East US"
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}
```

## Example adding a network security rule for SSH

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
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

resource "azurerm_network_security_group" "ssh" {
  name                = "ssh"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}
```

## Example adding a route table

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "my-resources"
  location = "West Europe"
}

module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
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
  name                = "MyRouteTable"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_route" "example" {
  name                = "acceptanceTestRoute1"
  resource_group_name = azurerm_resource_group.example.name
  route_table_name    = azurerm_route_table.example.name
  address_prefix      = "10.1.0.0/16"
  next_hop_type       = "vnetlocal"
}

```

## Example configuring private link endpoint network policy

```hcl
module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    subnet2 = ["Microsoft.Storage", "Microsoft.Sql"],
    subnet3 = ["Microsoft.AzureActiveDirectory"]
  }

  subnet_enforce_private_link_endpoint_network_policies = {
    "subnet2" = true,
    "subnet3" = true
  }

  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.example]
}
```

## Example configuring private link service network policy

```hcl
module "vnet" {
  source              = "Azure/vnet/azurerm"
  resource_group_name = azurerm_resource_group.example.name
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

  depends_on = [azurerm_resource_group.example]
}
```

## Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We provide 2 ways to build, run, and test the module on a local development machine.  [Native (Mac/Linux)](#native-maclinux) or [Docker](#docker).

### Native (Mac/Linux)

#### Prerequisites

- [Ruby **(~> 2.3)**](https://www.ruby-lang.org/en/downloads/)
- [Bundler **(~> 1.15)**](https://bundler.io/)
- [Terraform **(~> 0.11.7)**](https://www.terraform.io/downloads.html)
- [Golang **(~> 1.10.3)**](https://golang.org/dl/)

#### Environment setup

We provide simple script to quickly set up module development environment:

```sh
$ curl -sSL https://raw.githubusercontent.com/Azure/terramodtest/master/tool/env_setup.sh | sudo bash
```

#### Run test

Then simply run it in local shell:

```sh
$ cd $GOPATH/src/{directory_name}/
$ bundle install
$ rake build
$ rake full
```

### Docker

We provide a Dockerfile to build a new image based `FROM` the `microsoft/terraform-test` Docker hub image which adds additional tools / packages specific for this module (see Custom Image section).  Alternatively use only the `microsoft/terraform-test` Docker hub image [by using these instructions](https://github.com/Azure/terraform-test).

#### Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

#### Custom Image

This builds the custom image:

```sh
$ docker build --build-arg BUILD_ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID --build-arg BUILD_ARM_CLIENT_ID=$ARM_CLIENT_ID --build-arg BUILD_ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET --build-arg BUILD_ARM_TENANT_ID=$ARM_TENANT_ID -t azure-vnet .
```

This runs the build and unit tests:

```sh
$ docker run --rm azure-vnet /bin/bash -c "bundle install && rake build"
```

This runs the end to end tests:

```sh
$ docker run --rm azure-vnet /bin/bash -c "bundle install && rake e2e"
```

This runs the full tests:

```sh
$ docker run --rm azure-vnet /bin/bash -c "bundle install && rake full"
```

## Authors

Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)

## License

[MIT](LICENSE)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version |
|---------------------------------------------------------------------------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.21 |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.21 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                | Type        |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                     | resource    |
| [azurerm_subnet_network_security_group_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource    |
| [azurerm_subnet_route_table_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association)                       | resource    |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)                                                     | resource    |
| [azurerm_resource_group.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group)                                                    | data source |

## Inputs

| Name                                                                                                                                                                                                          | Description                                                                                  | Type                                                                    | Default                                                          | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|------------------------------------------------------------------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space)                                                                                                                                   | The address space that is used by the virtual network.                                       | `list(string)`                                                          | <pre>[<br>  "10.0.0.0/16"<br>]</pre>                             |    no    |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan)                                                                                                            | The set of DDoS protection plan configuration                                                | <pre>object({<br>    enable = bool<br>    id     = string<br>  })</pre> | `null`                                                           |    no    |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)                                                                                                                                         | The DNS servers to be used with vNet.                                                        | `list(string)`                                                          | `[]`                                                             |    no    |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids)                                                                                                                                                     | A map of subnet name to Network Security Group IDs                                           | `map(string)`                                                           | `{}`                                                             |    no    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                                                                                               | Name of the resource group to be imported.                                                   | `string`                                                                | n/a                                                              |   yes    |
| <a name="input_route_tables_ids"></a> [route\_tables\_ids](#input\_route\_tables\_ids)                                                                                                                        | A map of subnet name to Route table ids                                                      | `map(string)`                                                           | `{}`                                                             |    no    |
| <a name="input_subnet_delegation"></a> [subnet\_delegation](#input\_subnet\_delegation)                                                                                                                       | A map of subnet name to delegation block on the subnet                                       | `map(map(any))`                                                         | `{}`                                                             |    no    |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map of subnet name to enable/disable private link endpoint network policies on the subnet. | `map(bool)`                                                             | `{}`                                                             |    no    |
| <a name="input_subnet_enforce_private_link_service_network_policies"></a> [subnet\_enforce\_private\_link\_service\_network\_policies](#input\_subnet\_enforce\_private\_link\_service\_network\_policies)    | A map of subnet name to enable/disable private link service network policies on the subnet.  | `map(bool)`                                                             | `{}`                                                             |    no    |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names)                                                                                                                                      | A list of public subnets inside the vNet.                                                    | `list(string)`                                                          | <pre>[<br>  "subnet1",<br>  "subnet2",<br>  "subnet3"<br>]</pre> |    no    |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes)                                                                                                                             | The address prefix to use for the subnet.                                                    | `list(string)`                                                          | <pre>[<br>  "10.0.1.0/24"<br>]</pre>                             |    no    |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints)                                                                                                | A map of subnet name to service endpoints to add to the subnet.                              | `map(any)`                                                              | `{}`                                                             |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                                                                                | The tags to associate with your network and subnets.                                         | `map(string)`                                                           | <pre>{<br>  "ENV": "test"<br>}</pre>                             |    no    |
| <a name="input_vnet_location"></a> [vnet\_location](#input\_vnet\_location)                                                                                                                                   | The location of the vnet to create. Defaults to the location of the resource group.          | `string`                                                                | `null`                                                           |    no    |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name)                                                                                                                                               | Name of the vnet to create                                                                   | `string`                                                                | `"acctvnet"`                                                     |    no    |

## Outputs

| Name                                                                                           | Description                                              |
|------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space) | The address space of the newly created vNet              |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id)                                    | The id of the newly created vNet                         |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location)                  | The location of the newly created vNet                   |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name)                              | The Name of the newly created vNet                       |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets)                     | The ids of subnets created inside the newly created vNet |
<!-- END_TF_DOCS -->
