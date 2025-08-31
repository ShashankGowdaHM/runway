output "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone."
  value       = azurerm_private_dns_zone.private_dns_zone.id
}

output "soa_record" {
  description = "SOA record block."
  value       = azurerm_private_dns_zone.private_dns_zone.soa_record
}

output "number_of_record_sets" {
  description = "The current number of record sets in private_dns_zone Private DNS zone."
  value       = azurerm_private_dns_zone.private_dns_zone.number_of_record_sets
}

output "max_number_of_record_sets" {
  description = "The maximum number of record sets that can be created."
  value       = azurerm_private_dns_zone.private_dns_zone.max_number_of_record_sets
}

output "max_virtual_network_links" {
  description = "The maximum number of virtual network links."
  value       = azurerm_private_dns_zone.private_dns_zone.max_number_of_virtual_network_links
}

output "max_vnet_links_with_registration" {
  description = "Maximum virtual network links with registration."
  value       = azurerm_private_dns_zone.private_dns_zone.max_number_of_virtual_network_links_with_registration
}
