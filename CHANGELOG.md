# 3.0.0 (Sep 5, 2022)

The goal of v3.0.0 is to add a GitHub Action-based CI pipeline and introduce modern acceptance tests to ensure that future pull requests to this module meet our new standard for AzureRM modules.

The module's code is the same except we've sorted blocks and assignments to meet our new requirement in the CI pipeline.

We also upgrade the requirements of Terraform Core and AzureRM provider.

ENHANCEMENTS:

Now Terraform's version constraint is `>=1.2` since 1.2 has introduced some [new features](https://github.com/hashicorp/terraform/blob/v1.2/CHANGELOG.md) that can improve module's code quality.
Now AzureRM provider's version constraint is `~> 3.0` since v2.x is no longer maintained.

BUG FIXES:
