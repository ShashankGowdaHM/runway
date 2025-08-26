##############################################################
# Outputs for Web Application Firewall (WAF) Policy Module
# HP Runway Compliance:
#  - All outputs must be documented with clear descriptions.
#  - Sensitive values are explicitly marked to prevent accidental exposure.
#  - Outputs expose IDs and configurations required by downstream modules.
##############################################################

# ----------------------------------------------------------
# Core WAF Policy Outputs
# ----------------------------------------------------------

# The unique ID of the WAF Policy resource.
output "id" {
  description = "The ID of the Web Application Firewall Policy."
  value       = azurerm_web_application_firewall_policy.waf.id
}

# The name of the WAF Policy (useful for tagging or references).
output "name" {
  description = "The name of the Web Application Firewall Policy."
  value       = azurerm_web_application_firewall_policy.waf.name
}

# The resource group where the WAF policy is deployed.
output "resource_group_name" {
  description = "The name of the resource group containing the WAF Policy."
  value       = azurerm_web_application_firewall_policy.waf.resource_group_name
}

# The location (Azure region) where the WAF policy is deployed.
output "location" {
  description = "The Azure region where the WAF Policy is deployed."
  value       = azurerm_web_application_firewall_policy.waf.location
}

# ----------------------------------------------------------
# Application Gateway Associations
# ----------------------------------------------------------

# IDs of HTTP Listeners associated with the WAF policy.
output "http_listener_ids" {
  description = "A list of HTTP Listener IDs from an associated Application Gateway."
  value       = azurerm_web_application_firewall_policy.waf.http_listener_ids
}

# IDs of path-based routing rules associated with the WAF policy.
output "path_based_rule_ids" {
  description = "A list of URL Path Map Path Rule IDs from an associated Application Gateway."
  value       = azurerm_web_application_firewall_policy.waf.path_based_rule_ids
}

# ----------------------------------------------------------
# Policy Configuration Details
# ----------------------------------------------------------

# Settings configured for the WAF policy (mode, size limits, etc.).
output "policy_settings" {
  description = "The configuration settings of the WAF policy (mode, size limits, enforcement flags)."
  value       = azurerm_web_application_firewall_policy.waf.policy_settings
}

# Custom rules applied to the WAF policy.
output "custom_rules" {
  description = "List of custom rules configured for this WAF policy."
  value       = azurerm_web_application_firewall_policy.waf.custom_rules
}

# Managed rulesets applied to the WAF policy.
output "managed_rules" {
  description = "List of managed rulesets configured for this WAF policy."
  value       = azurerm_web_application_firewall_policy.waf.managed_rules
}

# ----------------------------------------------------------
# Tags & Metadata
# ----------------------------------------------------------

# Tags assigned to the WAF policy for governance and tracking.
output "tags" {
  description = "The tags applied to the WAF Policy."
  value       = azurerm_web_application_firewall_policy.waf.tags
}

# ----------------------------------------------------------
# Sensitive Outputs (Avoid exposing in logs)
# ----------------------------------------------------------

# The full resource ID is sometimes treated as sensitive in enterprise contexts.
# Marking as sensitive prevents accidental logging in pipelines.
output "waf_policy_resource_id_sensitive" {
  description = "Sensitive WAF Policy resource ID (for secure references in pipelines)."
  value       = azurerm_web_application_firewall_policy.waf.id
  sensitive   = true
}
