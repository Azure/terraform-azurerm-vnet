package unit

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPlan(t *testing.T) {
	tfOptions := &terraform.Options{
		TerraformDir: "../fixture",
		Vars:         map[string]interface{}{},
	}

	terraform.Init(t, tfOptions)
	terraform.Plan(t, tfOptions)
}
