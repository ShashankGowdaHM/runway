output "id" {
  description = "The ID of the Windows Function App."
  value       = azurerm_windows_function_app.windows_function_app.id
}

output "custom_domain_verification_id" {
  description = "The identifier used by App Service to perform domain ownership verification via DNS TXT record."
  value       = azurerm_windows_function_app.windows_function_app.custom_domain_verification_id
}

output "default_hostname" {
  description = "The default hostname of the Windows Function App."
  value       = azurerm_windows_function_app.windows_function_app.default_hostname
}

output "hosting_environment_id" {
  description = "The ID of the App Service Environment used by Function App."
  value       = azurerm_windows_function_app.windows_function_app.hosting_environment_id
}

output "identity" {
  description = "An identity block."
  value = azurerm_windows_function_app.windows_function_app.identity[0] != null ? {
    principal_id = azurerm_windows_function_app.windows_function_app.identity[0].principal_id
    tenant_id    = azurerm_windows_function_app.windows_function_app.identity[0].tenant_id
  } : null
}

output "kind" {
  description = "The Kind value for this Windows Function App."
  value       = azurerm_windows_function_app.windows_function_app.kind
}

output "outbound_ip_address_list" {
  description = "A list of outbound IP addresses."
  value       = azurerm_windows_function_app.windows_function_app.outbound_ip_address_list
}

output "outbound_ip_addresses" {
  description = "A comma separated list of outbound IP addresses as a string."
  value       = azurerm_windows_function_app.windows_function_app.outbound_ip_addresses
}

output "possible_outbound_ip_address_list" {
  description = "A list of possible outbound IP addresses, not all of which are necessarily in use."
  value       = azurerm_windows_function_app.windows_function_app.possible_outbound_ip_address_list
}

output "possible_outbound_ip_addresses" {
  description = "A comma separated list of possible outbound IP addresses as a string."
  value       = azurerm_windows_function_app.windows_function_app.possible_outbound_ip_addresses
}

output "site_credential" {
  description = "A site_credential block."
  value = {
    name     = azurerm_windows_function_app.windows_function_app.site_credential[0].name
    password = azurerm_windows_function_app.windows_function_app.site_credential[0].password
  }
  sensitive = true
}