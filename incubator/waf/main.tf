############################################################
# Azure Web Application Firewall (WAF) Policy
# ----------------------------------------------------------
# This module provisions an Azure WAF Policy with:
#   - Custom rules (user-defined conditions & actions)
#   - Policy settings (enforcement, request size limits, log scrubbing)
#   - Managed rule sets (e.g., OWASP CRS)
# 
# HP Runway Standards:
#   * Clear documentation for each resource
#   * Strict variable typing and validation
#   * Optional dynamic blocks with null-checks
#   * Consistent naming and tagging strategy
############################################################

resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  ########################################################
  # Custom Rules
  # ------------------------------------------------------
  # These rules allow explicit request filtering:
  #  - Match conditions (headers, query, body, IP, etc.)
  #  - Operators (Contains, Equals, IPMatch, etc.)
  #  - Actions (Allow, Block, Log)
  # 
  # Example use case: Block traffic from a malicious IP.
  ########################################################
  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name      = custom_rules.value.name
      priority  = custom_rules.value.priority         # Execution order (lower runs first)
      rule_type = custom_rules.value.rule_type        # "MatchRule" or "RateLimitRule"
      action    = custom_rules.value.action           # "Allow" | "Block" | "Log"
      enabled   = custom_rules.value.enabled

      # Match Conditions (what to inspect in the request)
      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          match_values       = match_conditions.value.match_values
          operator           = match_conditions.value.operator
          negation_condition = match_conditions.value.negation_condition
          transforms         = match_conditions.value.transforms

          # Match Variables (specific request components)
          dynamic "match_variables" {
            for_each = match_conditions.value.match_variables
            content {
              variable_name = match_variables.value.variable_name # e.g., "RequestHeaders"
              selector      = match_variables.value.selector      # optional key/field
            }
          }
        }
      }
    }
  }

  ########################################################
  # Policy Settings
  # ------------------------------------------------------
  # Controls how WAF enforces rules:
  #   * Mode: Detection vs. Prevention
  #   * Body size limits
  #   * Log scrubbing of sensitive fields
  ########################################################
  dynamic "policy_settings" {
    for_each = var.policy_settings != null ? [var.policy_settings] : []
    content {
      enabled                               = policy_settings.value.enabled
      mode                                  = policy_settings.value.mode # "Detection" | "Prevention"
      file_upload_limit_in_mb               = policy_settings.value.file_upload_limit_in_mb
      request_body_check                    = policy_settings.value.request_body_check
      max_request_body_size_in_kb           = policy_settings.value.max_request_body_size_in_kb
      request_body_enforcement              = policy_settings.value.request_body_enforcement
      request_body_inspect_limit_in_kb      = policy_settings.value.request_body_inspect_limit_in_kb
      js_challenge_cookie_expiration_in_minutes = policy_settings.value.js_challenge_cookie_expiration_in_minutes
      file_upload_enforcement               = policy_settings.value.file_upload_enforcement

      # Log Scrubbing (redact sensitive values in logs)
      dynamic "log_scrubbing" {
        for_each = policy_settings.value.log_scrubbing != null ? [policy_settings.value.log_scrubbing] : []
        content {
          enabled = log_scrubbing.value.enabled

          dynamic "rule" {
            for_each = log_scrubbing.value.rule
            content {
              enabled                 = rule.value.enabled
              match_variable          = rule.value.match_variable        # e.g., "RequestHeader"
              selector_match_operator = rule.value.selector_match_operator # "Equals", "Contains", etc.
              selector                = rule.value.selector              # field name (e.g., "Authorization")
            }
          }
        }
      }
    }
  }

  ########################################################
  # Managed Rules
  # ------------------------------------------------------
  # Baseline security via OWASP CRS or Microsoft defaults.
  # Can override individual groups/rules for fine tuning.
  ########################################################
  dynamic "managed_rules" {
    for_each = var.managed_rules
    content {
      dynamic "managed_rule_set" {
        for_each = managed_rules.value.managed_rule_set
        content {
          type    = managed_rule_set.value.type      # e.g., "OWASP"
          version = managed_rule_set.value.version   # e.g., "3.2"

          # Optional overrides to disable/tune certain rules
          dynamic "rule_group_override" {
            for_each = managed_rule_set.value.rule_group_override != null ? managed_rule_set.value.rule_group_override : []
            content {
              rule_group_name = rule_group_override.value.rule_group_name

              dynamic "rule" {
                for_each = rule_group_override.value.rule
                content {
                  id      = rule.value.id
                  enabled = rule.value.enabled
                  action  = rule.value.action
                }
              }
            }
          }
        }
      }
    }
  }

  ########################################################
  # Tags
  # ------------------------------------------------------
  # Ensure all resources are tagged for governance, cost,
  # and compliance tracking.
  ########################################################
  tags = var.tags
}
