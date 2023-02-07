package upgrade

import (
	"fmt"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamples(t *testing.T) {
	examples := []string{
		"examples/all_default",
		"examples/complete",
		"examples/new_route",
		"examples/new_security_rule",
		"examples/private_link_endpoint",
		"examples/private_link_service",
	}
	for _, example := range examples {
		e := example
		t.Run(fmt.Sprintf("%s_for_each", e), func(t *testing.T) {
			testExample(t, e, true)
		})
		t.Run(fmt.Sprintf("%s_count", e), func(t *testing.T) {
			testExample(t, e, false)
		})
	}
}

func testExample(t *testing.T, exampleRelativePath string, useForEach bool) {
	currentRoot, err := test_helper.GetCurrentModuleRootPath()
	if err != nil {
		t.FailNow()
	}
	currentMajorVersion, err := test_helper.GetCurrentMajorVersionFromEnv()
	if err != nil {
		t.FailNow()
	}
	vars := map[string]interface{}{
		"use_for_each": useForEach,
	}
	test_helper.ModuleUpgradeTest(t, "Azure", "terraform-azurerm-vnet", exampleRelativePath, currentRoot, terraform.Options{
		Upgrade: true,
		Vars:    vars,
	}, currentMajorVersion)
}
