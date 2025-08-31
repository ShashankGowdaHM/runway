output "container_app_id" {
  description = "The ID of the Container App."
  value       = azurerm_container_app.container_app.id
}

output "container_app_name" {
  description = "The name of the Container App."
  value       = azurerm_container_app.container_app.name
}

output "container_app_url" {
  description = "The default URL of the Container App."
  value       = azurerm_container_app.container_app.latest_revision_fqdn
}
