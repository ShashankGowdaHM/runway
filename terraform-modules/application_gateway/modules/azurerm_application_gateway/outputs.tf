output "application_gateway_id" {
  description = "The ID of the Application Gateway."
  value       = azurerm_application_gateway.application_gateway.id
}

output "application_gateway_frontend_ip_configurations" {
  description = "The frontend IP configurations of the Application Gateway."
  value       = azurerm_application_gateway.application_gateway.frontend_ip_configuration
}

output "application_gateway_backend_address_pools" {
  description = "The backend address pools of the Application Gateway."
  value       = azurerm_application_gateway.application_gateway.backend_address_pool
}

output "application_gateway_http_listeners" {
  description = "The HTTP listeners of the Application Gateway."
  value       = azurerm_application_gateway.application_gateway.http_listener
}
