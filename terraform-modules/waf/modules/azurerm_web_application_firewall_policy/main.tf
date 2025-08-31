# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name     = custom_rules.value.name
      priority = custom_rules.value.priority
      rule_type = custom_rules.value.rule_type
      action   = custom_rules.value.action
      enabled  = custom_rules.value.enabled

      dynamic "match_conditions" {
        for_each = custom_rules.value.match_conditions
        content {
          match_values        = match_conditions.value.match_values
          operator            = match_conditions.value.operator
          negation_condition  = match_conditions.value.negation_condition
          transforms          = match_conditions.value.transforms

          dynamic "match_variables" {
            for_each = match_conditions.value.match_variables
            content {
              variable_name = match_variables.value.variable_name
              selector      = match_variables.value.selector
            }
          }
        }
      }
    }
  }

  dynamic "policy_settings" {
    for_each = var.policy_settings != null ? [var.policy_settings] : []
    content {
      enabled                               = policy_settings.value.enabled
      mode                                  = policy_settings.value.mode
      file_upload_limit_in_mb               = policy_settings.value.file_upload_limit_in_mb
      request_body_check                    = policy_settings.value.request_body_check
      max_request_body_size_in_kb           = policy_settings.value.max_request_body_size_in_kb
      request_body_enforcement              = policy_settings.value.request_body_enforcement
      request_body_inspect_limit_in_kb      = policy_settings.value.request_body_inspect_limit_in_kb
      js_challenge_cookie_expiration_in_minutes = policy_settings.value.js_challenge_cookie_expiration_in_minutes
      file_upload_enforcement               = policy_settings.value.file_upload_enforcement

      dynamic "log_scrubbing" {
        for_each = policy_settings.value.log_scrubbing != null ? [policy_settings.value.log_scrubbing] : []
        content {
          enabled = log_scrubbing.value.enabled
          dynamic "rule" {
            for_each = log_scrubbing.value.rule
            content {
              enabled               = rule.value.enabled
              match_variable        = rule.value.match_variable
              selector_match_operator = rule.value.selector_match_operator
              selector              = rule.value.selector
            }
          }
        }
      }
    }
  }

  dynamic "managed_rules" {
    for_each = var.managed_rules
    content {
      dynamic "managed_rule_set" {
        for_each = managed_rules.value.managed_rule_set
        content {
          type    = managed_rule_set.value.type
          version = managed_rule_set.value.version

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

  tags = var.tags
}
