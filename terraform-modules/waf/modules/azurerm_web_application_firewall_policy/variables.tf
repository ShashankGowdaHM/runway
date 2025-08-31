variable "name" {
  description = "The name of the Web Application Firewall Policy."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the WAF policy will be created."
  type        = string
}

variable "location" {
  description = "The location where the WAF policy will be created."
  type        = string
}

variable "custom_rules" {
  description = "List of custom rules to apply to the WAF policy."
  type = list(object({
    name                   = string
    priority               = number
    rule_type              = string
    action                 = string
    enabled                = optional(bool, true)
    rate_limit_duration    = optional(string)
    rate_limit_threshold   = optional(number)
    group_rate_limit_by    = optional(string)
    match_conditions = list(object({
      match_variables = list(object({
        variable_name = string
        selector      = optional(string)
      }))
      match_values        = optional(list(string))
      operator           = string
      negation_condition = optional(bool)
      transforms         = optional(list(string))
    }))
  }))
  default = []
}

variable "policy_settings" {
  description = "Settings for the WAF policy."
  type = object({
    enabled                               = optional(bool, true)
    mode                                  = optional(string, "Prevention")
    file_upload_limit_in_mb               = optional(number, 100)
    request_body_check                    = optional(bool, true)
    max_request_body_size_in_kb           = optional(number, 128)
    request_body_enforcement              = optional(bool, true)
    request_body_inspect_limit_in_kb      = optional(number, 128)
    js_challenge_cookie_expiration_in_minutes = optional(number, 30)
    file_upload_enforcement               = optional(bool, false)
    log_scrubbing = optional(object({
      enabled = optional(bool, true)
      rule = list(object({
        enabled               = optional(bool, true)
        match_variable        = string
        selector_match_operator = optional(string, "Equals")
        selector              = optional(string)
      }))
    }))
  })
  default = null
}

variable "managed_rules" {
  description = "Managed rule sets for the WAF policy."
  type = list(object({
    managed_rule_set = list(object({
      type     = string
      version  = string
      rule_group_override = optional(list(object({
        rule_group_name = string
        rule = list(object({
          id      = string
          enabled = optional(bool, false)
          action  = optional(string)
        }))
      })))
    }))
  }))
}

variable "tags" {
  description = "Tags to assign to the Web Application Firewall Policy."
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  description = "Subscription id where the WAF policy is created"
  type        = string
}