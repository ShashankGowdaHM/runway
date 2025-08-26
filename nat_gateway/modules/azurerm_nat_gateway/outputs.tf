output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = azurerm_nat_gateway.nat_gateway.id
}

output "nat_gateway_resource_guid" {
  description = "The resource GUID of the NAT Gateway."
  value       = azurerm_nat_gateway.nat_gateway.resource_guid
}
