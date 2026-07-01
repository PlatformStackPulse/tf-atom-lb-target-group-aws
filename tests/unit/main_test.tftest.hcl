# Unit Tests — tf-atom-lb-target-group-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run one test:     terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# Assertions target PLAN-KNOWN values only (tf-label id, resource count,
# input pass-throughs, configured resource attributes). Computed attributes
# such as arn/arn_suffix/id are unknown under a mock provider and are only
# asserted to be null in the disabled case.

mock_provider "aws" {}

variables {
  # tf-label identity
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module-specific required input
  vpc_id = "vpc-0abc123def4567890"

  # non-default sample values to assert pass-through
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
}

# ---------------------------------------------------------------------------
# Test: module creates the target group when enabled
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = length(aws_lb_target_group.this) == 1
    error_message = "Expected exactly one aws_lb_target_group when enabled."
  }

  assert {
    condition     = output.name == "eg-test-thing"
    error_message = "Target group name should equal the tf-label id 'eg-test-thing'."
  }

  assert {
    condition     = aws_lb_target_group.this[0].port == 8080
    error_message = "port input should pass through to the target group."
  }

  assert {
    condition     = aws_lb_target_group.this[0].target_type == "ip"
    error_message = "target_type input should pass through to the target group."
  }
}

# ---------------------------------------------------------------------------
# Test: module creates nothing when disabled
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_lb_target_group.this) == 0
    error_message = "No target group should be created when enabled = false."
  }

  assert {
    condition     = output.arn == null
    error_message = "arn output should be null when the module is disabled."
  }
}
