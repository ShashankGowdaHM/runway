output "name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.rg.location
}

output "resource_group_tags" {
  description = "A mapping of tags assigned to the Resource Group"
  value       = azurerm_resource_group.rg.tags
}