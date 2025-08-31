##############################################################
# Outputs for Private Endpoint Module
# These outputs expose key details of the deployed private endpoint
# for downstream modules and consumers (e.g., networking, DNS setup).
# HP Runway Standard: Add descriptions, mark sensitive values, 
# and provide structured outputs for easier consumption.
##############################################################

# -------------------------------
# Private Endpoint Resource ID
# -------------------------------
# Exposes the unique Azure resource ID for the private endpoint.
# Useful for referencing in other modules, policies, or monitoring.
output "private_endpoint_id" {
  description = "The unique resource ID of the Private Endpoint."
  value       = azurerm_private_endpoint.private_endpoint.id
}

# -------------------------------
# Network Interface Details
# -------------------------------
# Exposes the NIC (Network Interface Card) associated with the private endpoint.
# Provides both NIC ID and name for flexibility in consumption.
output "network_interface" {
  description = "The network interface (NIC) associated with the private endpoint."
  value = {
    id   = azurerm_private_endpoint.private_endpoint.network_interface[0].id
    name = azurerm_private_endpoint.private_endpoint.network_interface[0].name
  }
}

# -------------------------------
# Custom DNS Configurations
# -------------------------------
# Contains custom DNS records assigned to the private endpoint.
# Sensitive because it can reveal internal FQDNs or IP mapping.
output "custom_dns_configs" {
  description = "The custom DNS configurations for the private endpoint."
  value       = azurerm_private_endpoint.private_endpoint.custom_dns_configs
  sensitive   = true
}

# -------------------------------
# Private DNS Zone Configurations
# -------------------------------
# Details of private DNS zone links/configs used by the private endpoint.
# Helpful for debugging DNS resolution and linking.
output "private_dns_zone_configs" {
  description = "The private DNS zone configurations for the private endpoint."
  value       = azurerm_private_endpoint.private_endpoint.private_dns_zone_configs
}

# -------------------------------
# IP Configurations
# -------------------------------
# Exposes the private IP addresses allocated to the private endpoint NIC.
# Marked as sensitive since it contains internal networking details.
output "ip_configurations" {
  description = "The IP configurations (private IPs) of the private endpoint."
  value       = azurerm_private_endpoint.private_endpoint.ip_configuration
  sensitive   = true
}
