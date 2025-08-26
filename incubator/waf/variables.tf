##############################################
# Variables for WAF Policy Module
# HP Runway Standards: Clear descriptions, 
# required vs optional flagged, validations applied
##############################################

variable "name" {
  description = "(Required) The name of the Web Application Firewall (WAF) Policy. Must be unique within the resource group."
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 80
    error_message = "The 'name' variable must be provided and cannot exceed 80 characters."
  }
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where the WAF policy will be created."
  type        = string

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "The 'resource_group_name' variable must be provided."
  }
}

variable "location" {
  description = "(Required) The Azure region where the WAF policy will be created (e.g., eastus, westeurope)."
  type        = string

  validation {
    condition     = length(var.location) > 0
    error_message = "The 'location' variable must be provided and cannot be empty."
  }
}

variable "custom_rules" {
  description = "(Optional) List of custom WAF rules to apply. If empty, no custom rules will be created."
  type = list(object({
    name                   = string
    priority               = number
    rule_type              = string                  # Possible values: MatchRule, RateLimitRule
    action                 = string                  # Possible values: Allow, Block, Log, Redirect
    enabled                = optional(bool, true)
    rate_limit_duration    = optional(string)        # For rate limiting rules
    rate_limit_threshold   = optional(number)        # Threshold count
    group_rate_limit_by    = optional(string)        # e.g., ClientAddr

    match_conditions = list(object({
      match_variables = list(object({
        variable_name = string                      # e.g., RemoteAddr, RequestHeader
        selector      = optional(string)
      }))
      match_values        = optional(list(string))
      operator            = string                  # e.g., IPMatch, Contains, Equals
      negation_condition  = optional(bool)
      transforms          = optional(list(string))  # e.g., Lowercase, UrlDecode
    }))
  }))
  default = []
}

variable "policy_settings" {
  description = "(Optional) General settings for the WAF policy. If null, defaults are applied."
  type = object({
    enabled                               = optional(bool, true)
    mode                                  = optional(string, "Prevention") # Detection or Prevention
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
        enabled                 = optional(bool, true)
        match_variable          = string
        selector_match_operator = optional(string, "Equals")
        selector                = optional(string)
      }))
    }))
  })
  default = null
}

variable "managed_rules" {
  description = "(Required) Managed rule sets for the WAF policy. At least one managed rule set must be defined."
  type = list(object({
    managed_rule_set = list(object({
      type     = string         # Example: OWASP
      version  = string         # Example: 3.2
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

  validation {
    condition     = length(var.managed_rules) > 0
    error_message = "At least one managed_rules block must be defined (e.g., OWASP rule set)."
  }
}

variable "tags" {
  description = "(Optional) Tags to assign to the Web Application Firewall Policy. Useful for governance and cost tracking."
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  description = "(Required) The Azure Subscription ID where the WAF policy will be deployed."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "The 'subscription_id' must be a valid GUID."
  }
}
