output "private_endpoint_id" {
  description = "The ID of the Private Endpoint"
  value       = azurerm_private_endpoint.private_endpoint.id
}

output "network_interface" {
  description = "The network interface associated with the private endpoint"
  value = {
    id   = azurerm_private_endpoint.private_endpoint.network_interface[0].id
    name = azurerm_private_endpoint.private_endpoint.network_interface[0].name
  }
}

output "custom_dns_configs" {
  description = "The custom DNS configurations for the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.custom_dns_configs
}

output "private_dns_zone_configs" {
  description = "The private DNS zone configurations for the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.private_dns_zone_configs
}

output "ip_configurations" {
  description = "The IP configurations for the private endpoint"
  value       = azurerm_private_endpoint.private_endpoint.ip_configuration
}
