##############################################
# Outputs for Key Vault Module
# HP Runway Standards: Clear descriptions,
# sensitive values flagged, and consistency applied
##############################################

# (Required) The unique resource ID of the Key Vault
output "id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.key_vault.id
}

# (Required) The URI of the Key Vault, used for operations on keys and secrets
output "vault_uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets."
  value       = azurerm_key_vault.key_vault.vault_uri
}

# (Optional) The name of the Key Vault
output "name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.key_vault.name
}

# (Optional) The location (region) where the Key Vault is deployed
output "location" {
  description = "The Azure region where the Key Vault is deployed."
  value       = azurerm_key_vault.key_vault.location
}

# (Optional) The resource group name where the Key Vault resides
output "resource_group_name" {
  description = "The name of the Resource Group containing the Key Vault."
  value       = azurerm_key_vault.key_vault.resource_group_name
}

# (Optional) The Tenant ID for Azure Active Directory that should be used for authenticating requests
output "tenant_id" {
  description = "The Azure Active Directory Tenant ID associated with the Key Vault."
  value       = azurerm_key_vault.key_vault.tenant_id
  sensitive   = true
}

# (Optional) The soft delete retention days for Key Vault
output "soft_delete_retention_days" {
  description = "Number of days that items should be retained after deletion (soft delete)."
  value       = azurerm_key_vault.key_vault.soft_delete_retention_days
}

# (Optional) Indicates whether purge protection is enabled
output "purge_protection_enabled" {
  description = "Boolean flag to indicate if purge protection is enabled on this Key Vault."
  value       = azurerm_key_vault.key_vault.purge_protection_enabled
}
