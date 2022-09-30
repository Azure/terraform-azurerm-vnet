package upgrade

import (
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamples(t *testing.T) {
	examples := []string{
		"examples/complete",
		"examples/new_route",
		"examples/new_security_rule",
		"examples/private_link_endpoint",
		"examples/private_link_service",
	}
	for _, example := range examples {
		t.Run(example, func(t *testing.T) {
			testExample(t, example)
		})
	}
}

func testExample(t *testing.T, exampleRelativePath string) {
	currentRoot, err := test_helper.GetCurrentModuleRootPath()
	if err != nil {
		t.FailNow()
	}
	currentMajorVersion, err := test_helper.GetCurrentMajorVersionFromEnv()
	if err != nil {
		t.FailNow()
	}
	test_helper.ModuleUpgradeTest(t, "Azure", "terraform-azurerm-vnet", exampleRelativePath, currentRoot, terraform.Options{
		Upgrade: true,
	}, currentMajorVersion)
}
