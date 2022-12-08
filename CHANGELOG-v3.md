# Changelog

## [3.2.0](https://github.com/Azure/terraform-azurerm-vnet/tree/3.2.0) (2022-12-08)

**Merged pull requests:**

- Add new variable `use_for_each` so we can use `for_each` to create multiple resource instances. [\#92](https://github.com/Azure/terraform-azurerm-vnet/pull/92) ([lonegunmanb](https://github.com/lonegunmanb))

## [3.1.0](https://github.com/Azure/terraform-azurerm-vnet/tree/3.1.0) (2022-12-07)

**Merged pull requests:**

- Bump tflint plugin version, add new rule [\#91](https://github.com/Azure/terraform-azurerm-vnet/pull/91) ([lonegunmanb](https://github.com/lonegunmanb))
- Ci updating breaking-change-detect [\#90](https://github.com/Azure/terraform-azurerm-vnet/pull/90) ([Pumpkin-3906](https://github.com/Pumpkin-3906))
- Upgrade `terraform-module-test-helper` lib so we can get rid of override file to execute version upgrade test [\#89](https://github.com/Azure/terraform-azurerm-vnet/pull/89) ([lonegunmanb](https://github.com/lonegunmanb))
- Add support for `bgp_community` [\#88](https://github.com/Azure/terraform-azurerm-vnet/pull/88) ([lonegunmanb](https://github.com/lonegunmanb))
- update outputs.tf to bracket syntax [\#86](https://github.com/Azure/terraform-azurerm-vnet/pull/86) ([Pumpkin-3906](https://github.com/Pumpkin-3906))
- Add update changelog step in CI pipeline, update pull request template [\#82](https://github.com/Azure/terraform-azurerm-vnet/pull/82) ([lonegunmanb](https://github.com/lonegunmanb))
- Bump test helper version [\#79](https://github.com/Azure/terraform-azurerm-vnet/pull/79) ([lonegunmanb](https://github.com/lonegunmanb))

## [3.0.0](https://github.com/Azure/terraform-azurerm-vnet/tree/3.0.0) (2022-10-18)

**Implemented enhancements:**

- Allow configure enforce\_private\_link\_endpoint\_network\_policies and enforce\_private\_link\_service\_network\_policies params for subnets [\#40](https://github.com/Azure/terraform-azurerm-vnet/pull/40) ([mathsnunes](https://github.com/mathsnunes))

**Merged pull requests:**

- Add a CI step to detect potential breaking changes. [\#75](https://github.com/Azure/terraform-azurerm-vnet/pull/75) ([lonegunmanb](https://github.com/lonegunmanb))
- Limit `azurerm`'s version to `>= 3.11, < 4.0` [\#74](https://github.com/Azure/terraform-azurerm-vnet/pull/74) ([lonegunmanb](https://github.com/lonegunmanb))
- Fix default subnet prefixes [\#73](https://github.com/Azure/terraform-azurerm-vnet/pull/73) ([lonegunmanb](https://github.com/lonegunmanb))
- Remove datasource `azurerm_resource_group.vnet`. [\#72](https://github.com/Azure/terraform-azurerm-vnet/pull/72) ([lonegunmanb](https://github.com/lonegunmanb))
- Prepare for CI [\#71](https://github.com/Azure/terraform-azurerm-vnet/pull/71) ([lonegunmanb](https://github.com/lonegunmanb))
- add ddos\_protection\_plan configuration to vnet [\#66](https://github.com/Azure/terraform-azurerm-vnet/pull/66) ([jeongkyeong](https://github.com/jeongkyeong))
- Adding Microsoft SECURITY.MD [\#64](https://github.com/Azure/terraform-azurerm-vnet/pull/64) ([microsoft-github-policy-service[bot]](https://github.com/apps/microsoft-github-policy-service))
- fix: correct typo in description of vnet\_subnets output [\#58](https://github.com/Azure/terraform-azurerm-vnet/pull/58) ([mrparkers](https://github.com/mrparkers))
- Added new output "vnet\_subnets\_name\_id" [\#55](https://github.com/Azure/terraform-azurerm-vnet/pull/55) ([vinshetty](https://github.com/vinshetty))
- Add delegation support to subnet [\#48](https://github.com/Azure/terraform-azurerm-vnet/pull/48) ([stanleyz](https://github.com/stanleyz))
- add variable `vnet_location` to customize vnet location [\#45](https://github.com/Azure/terraform-azurerm-vnet/pull/45) ([yupwei68](https://github.com/yupwei68))
- Update README.md [\#42](https://github.com/Azure/terraform-azurerm-vnet/pull/42) ([sionsmith](https://github.com/sionsmith))
- Docker fix [\#39](https://github.com/Azure/terraform-azurerm-vnet/pull/39) ([yupwei68](https://github.com/yupwei68))
- Integration of Terramodtest 0.8.0  [\#38](https://github.com/Azure/terraform-azurerm-vnet/pull/38) ([yupwei68](https://github.com/yupwei68))
- Create pull\_request\_template.md [\#37](https://github.com/Azure/terraform-azurerm-vnet/pull/37) ([yupwei68](https://github.com/yupwei68))
- Add local variables to prevent unnecessary force replacement and update ReadMe [\#36](https://github.com/Azure/terraform-azurerm-vnet/pull/36) ([yupwei68](https://github.com/yupwei68))
- Update README.md [\#35](https://github.com/Azure/terraform-azurerm-vnet/pull/35) ([stephaneclavel](https://github.com/stephaneclavel))
- Update README.md [\#34](https://github.com/Azure/terraform-azurerm-vnet/pull/34) ([allengeer](https://github.com/allengeer))
- Terraform 0.13 support [\#30](https://github.com/Azure/terraform-azurerm-vnet/pull/30) ([yupwei68](https://github.com/yupwei68))
- Update deprecated field `address_prefix` [\#29](https://github.com/Azure/terraform-azurerm-vnet/pull/29) ([yupwei68](https://github.com/yupwei68))
- Remove resources reference quotes [\#26](https://github.com/Azure/terraform-azurerm-vnet/pull/26) ([bamaralf](https://github.com/bamaralf))
- Support Azurerm 2.0 and removal of resource group [\#24](https://github.com/Azure/terraform-azurerm-vnet/pull/24) ([yupwei68](https://github.com/yupwei68))
- Add Terratest [\#14](https://github.com/Azure/terraform-azurerm-vnet/pull/14) ([foreverXZC](https://github.com/foreverXZC))
- Add route tables to subnets [\#7](https://github.com/Azure/terraform-azurerm-vnet/pull/7) ([jmapro](https://github.com/jmapro))
- Adding support for associating a subnet and network security group [\#6](https://github.com/Azure/terraform-azurerm-vnet/pull/6) ([rguthriemsft](https://github.com/rguthriemsft))
- Updated the name to vnet in Readme [\#5](https://github.com/Azure/terraform-azurerm-vnet/pull/5) ([VaijanathB](https://github.com/VaijanathB))
- updating travls to correct script [\#4](https://github.com/Azure/terraform-azurerm-vnet/pull/4) ([rguthriemsft](https://github.com/rguthriemsft))
- Updating travis and dockerfile [\#3](https://github.com/Azure/terraform-azurerm-vnet/pull/3) ([rguthriemsft](https://github.com/rguthriemsft))
- Fixing test to use local files [\#2](https://github.com/Azure/terraform-azurerm-vnet/pull/2) ([rguthriemsft](https://github.com/rguthriemsft))
- Update README.md [\#1](https://github.com/Azure/terraform-azurerm-vnet/pull/1) ([rguthriemsft](https://github.com/rguthriemsft))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
