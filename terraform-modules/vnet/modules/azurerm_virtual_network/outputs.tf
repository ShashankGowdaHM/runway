output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "vnet_guid" {
  description = "The GUID of the newly created vNet"
  value       = azurerm_virtual_network.vnet.guid
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet.location
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_subnets" {
  description = "The ids of subnets created inside the newly created vNet"
  value       = [for subnet in azurerm_virtual_network.vnet.subnet : subnet.id]
}

output "vnet_subnets_name_id" {
  description = "Can be queried subnet-id by subnet name by using lookup(module.vnet.vnet_subnets_name_id, subnet1)"
  value       = { for subnet in azurerm_virtual_network.vnet.subnet : subnet.name => subnet.id }
}