output "id" {
  description = "The ID of the Container App Environment."
  value       = azurerm_container_app_environment.manenv.id
}

output "custom_domain_verification_id" {
  description = "The Custom Domain Verification ID."
  value       = azurerm_container_app_environment.manenv.custom_domain_verification_id
}

output "default_domain" {
  description = "The default domain of the environment."
  value       = azurerm_container_app_environment.manenv.default_domain
}

output "docker_bridge_cidr" {
  description = "Docker bridge CIDR (only if infrastructure_subnet_id is set)."
  value       = azurerm_container_app_environment.manenv.docker_bridge_cidr
}

output "platform_reserved_cidr" {
  description = "Platform reserved CIDR."
  value       = azurerm_container_app_environment.manenv.platform_reserved_cidr
}

output "platform_reserved_dns_ip_address" {
  description = "Platform reserved DNS IP."
  value       = azurerm_container_app_environment.manenv.platform_reserved_dns_ip_address
}

output "static_ip_address" {
  description = "Static IP address of the environment."
  value       = azurerm_container_app_environment.manenv.static_ip_address
}
