# terraform-azurerm-vnet

## Create a basic virtual network in Azure

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.

The module does not create nor expose a security group. This would need to be defined separately as additional security rules on subnets in the deployed network.

## Notice on Upgrade to V3.x

We've added a CI pipeline for this module to speed up our code review and to enforce a high code quality standard, if you want to contribute by submitting a pull request, please read [Pre-Commit & Pr-Check & Test](#Pre-Commit--Pr-Check--Test) section, or your pull request might be rejected by CI pipeline.

A pull request will be reviewed when it has passed Pre Pull Request Check in the pipeline, and will be merged when it has passed the acceptance tests. Once the ci Pipeline failed, please read the pipeline's output, thanks for your cooperation.

V3.0.0 is a major version upgrade. Extreme caution must be taken during the upgrade to avoid resource replacement and downtime by accident.

Running the `terraform plan` first to inspect the plan is strongly advised.

We kept most code untouched, but the following **breaking changes** might affect your stack:

* `var.vnet_location` now is required. [#72](https://github.com/Azure/terraform-azurerm-vnet/pull/72)
* `var.resource_group_name` now cannot be set to `null`. [#72](https://github.com/Azure/terraform-azurerm-vnet/pull/72)
* `var.subnet_prefixes`'s default value now is `["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]`. [#73](https://github.com/Azure/terraform-azurerm-vnet/pull/73)

### Terraform and terraform-provider-azurerm version restrictions

Now Terraform core's version is v1.x and terraform-provider-azurerm's version is v3.x.

## Example Usage

Please refer to the sub folders under `examples` folder. You can execute `terraform apply` command in `examples`'s sub folder to try the module. These examples are tested against every PR with the [E2E Test](#Pre-Commit--Pr-Check--Test).

## Pre-Commit & Pr-Check & Test

### Configurations

- [Configure Terraform for Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-install-configure)

We assumed that you have setup service principal's credentials in your environment variables like below:

```shell
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"
```

On Windows Powershell:

```shell
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"
$env:ARM_CLIENT_ID="<service_principal_appid>"
$env:ARM_CLIENT_SECRET="<service_principal_password>"
```

We provide a docker image to run the pre-commit checks and tests for you: `mcr.microsoft.com/azterraform:latest`

To run the pre-commit task, we can run the following command:

```shell
$ docker run --rm -v $(pwd):/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src mcr.microsoft.com/azterraform:latest make pre-commit
```

In pre-commit task, we will:

1. Run `terraform fmt -recursive` command for your Terraform code.
2. Run `terrafmt fmt -f` command for markdown files and go code files to ensure that the Terraform code embedded in these files are well formatted.
3. Run `go mod tidy` and `go mod vendor` for test folder to ensure that all the dependencies have been synced.
4. Run `gofmt` for all go code files.
5. Run `gofumpt` for all go code files.
6. Run `terraform-docs` on `README.md` file, then run `markdown-table-formatter` to format markdown tables in `README.md`.

Then we can run the pr-check task to check whether our code meets our pipeline's requirement(We strongly recommend you run the following command before you commit):

```shell
$ docker run --rm -v $(pwd):/src -w /src -e TFLINT_CONFIG=.tflint_alt.hcl mcr.microsoft.com/azterraform:latest make pr-check
```

On Windows Powershell:

```shell
$ docker run --rm -v ${pwd}:/src -w /src -e TFLINT_CONFIG=.tflint_alt.hcl mcr.microsoft.com/azterraform:latest make pr-check
```

To run the e2e-test, we can run the following command:

```text
docker run --rm -v $(pwd):/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

On Windows Powershell:

```text
docker run --rm -v ${pwd}:/src -w /src -e ARM_SUBSCRIPTION_ID -e ARM_TENANT_ID -e ARM_CLIENT_ID -e ARM_CLIENT_SECRET mcr.microsoft.com/azterraform:latest make e2e-test
```

#### Prerequisites

- [Docker](https://www.docker.com/community-edition#/download)

## Authors

Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)

## License

[MIT](LICENSE)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version        |
|---------------------------------------------------------------------------|----------------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2         |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.11, < 4.0 |

## Providers

| Name                                                          | Version        |
|---------------------------------------------------------------|----------------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.11, < 4.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)                                                                     | resource |
| [azurerm_subnet_network_security_group_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association)                       | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)                                                     | resource |

## Inputs

| Name                                                                                                                                                                                                          | Description                                                                                  | Type                                                                    | Default                                                                      | Required |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|------------------------------------------------------------------------------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space)                                                                                                                                   | The address space that is used by the virtual network.                                       | `list(string)`                                                          | <pre>[<br>  "10.0.0.0/16"<br>]</pre>                                         |    no    |
| <a name="input_ddos_protection_plan"></a> [ddos\_protection\_plan](#input\_ddos\_protection\_plan)                                                                                                            | The set of DDoS protection plan configuration                                                | <pre>object({<br>    enable = bool<br>    id     = string<br>  })</pre> | `null`                                                                       |    no    |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)                                                                                                                                         | The DNS servers to be used with vNet.                                                        | `list(string)`                                                          | `[]`                                                                         |    no    |
| <a name="input_nsg_ids"></a> [nsg\_ids](#input\_nsg\_ids)                                                                                                                                                     | A map of subnet name to Network Security Group IDs                                           | `map(string)`                                                           | `{}`                                                                         |    no    |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)                                                                                                               | Name of the resource group to be imported.                                                   | `string`                                                                | n/a                                                                          |   yes    |
| <a name="input_route_tables_ids"></a> [route\_tables\_ids](#input\_route\_tables\_ids)                                                                                                                        | A map of subnet name to Route table ids                                                      | `map(string)`                                                           | `{}`                                                                         |    no    |
| <a name="input_subnet_delegation"></a> [subnet\_delegation](#input\_subnet\_delegation)                                                                                                                       | A map of subnet name to delegation block on the subnet                                       | `map(map(any))`                                                         | `{}`                                                                         |    no    |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map of subnet name to enable/disable private link endpoint network policies on the subnet. | `map(bool)`                                                             | `{}`                                                                         |    no    |
| <a name="input_subnet_enforce_private_link_service_network_policies"></a> [subnet\_enforce\_private\_link\_service\_network\_policies](#input\_subnet\_enforce\_private\_link\_service\_network\_policies)    | A map of subnet name to enable/disable private link service network policies on the subnet.  | `map(bool)`                                                             | `{}`                                                                         |    no    |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names)                                                                                                                                      | A list of public subnets inside the vNet.                                                    | `list(string)`                                                          | <pre>[<br>  "subnet1",<br>  "subnet2",<br>  "subnet3"<br>]</pre>             |    no    |
| <a name="input_subnet_prefixes"></a> [subnet\_prefixes](#input\_subnet\_prefixes)                                                                                                                             | The address prefix to use for the subnet.                                                    | `list(string)`                                                          | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> |    no    |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints)                                                                                                | A map of subnet name to service endpoints to add to the subnet.                              | `map(any)`                                                              | `{}`                                                                         |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                                                                                                | The tags to associate with your network and subnets.                                         | `map(string)`                                                           | <pre>{<br>  "ENV": "test"<br>}</pre>                                         |    no    |
| <a name="input_vnet_location"></a> [vnet\_location](#input\_vnet\_location)                                                                                                                                   | The location of the vnet to create.                                                          | `string`                                                                | n/a                                                                          |   yes    |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name)                                                                                                                                               | Name of the vnet to create                                                                   | `string`                                                                | `"acctvnet"`                                                                 |    no    |

## Outputs

| Name                                                                                                   | Description                                                                                           |
|--------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| <a name="output_vnet_address_space"></a> [vnet\_address\_space](#output\_vnet\_address\_space)         | The address space of the newly created vNet                                                           |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id)                                            | The id of the newly created vNet                                                                      |
| <a name="output_vnet_location"></a> [vnet\_location](#output\_vnet\_location)                          | The location of the newly created vNet                                                                |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name)                                      | The Name of the newly created vNet                                                                    |
| <a name="output_vnet_subnets"></a> [vnet\_subnets](#output\_vnet\_subnets)                             | The ids of subnets created inside the newly created vNet                                              |
| <a name="output_vnet_subnets_name_id"></a> [vnet\_subnets\_name\_id](#output\_vnet\_subnets\_name\_id) | Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet\_subnets\_name\_id, subnet1) |
<!-- END_TF_DOCS -->
