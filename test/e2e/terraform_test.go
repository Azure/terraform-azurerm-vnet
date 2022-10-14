package e2e

import (
	"regexp"
	"testing"

	test_helper "github.com/Azure/terraform-module-test-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
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
		t.Run(example, func(t *testing.T) {
			testExample(t, example)
		})
	}
}

func testExample(t *testing.T, exampleRelativePath string) {
	test_helper.RunE2ETest(t, "../../", exampleRelativePath, terraform.Options{
		Upgrade: true,
	}, func(t *testing.T, output test_helper.TerraformOutput) {
		vnetId, ok := output["test_vnet_id"].(string)
		assert.True(t, ok)
		assert.Regexp(t, regexp.MustCompile("/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/virtualNetworks/.+"), vnetId)
	})
}
