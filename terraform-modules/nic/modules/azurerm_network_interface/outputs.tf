output "network_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "network_interface_mac_address" {
  value = azurerm_network_interface.nic.mac_address
}

output "network_interface_private_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "network_interface_private_ips" {
  value = azurerm_network_interface.nic.private_ip_addresses
}

output "network_interface_internal_domain_name_suffix" {
  value = azurerm_network_interface.nic.internal_domain_name_suffix
}

output "network_interface_applied_dns_servers" {
  value = azurerm_network_interface.nic.applied_dns_servers
}

output "network_interface_virtual_machine_id" {
  value = azurerm_network_interface.nic.virtual_machine_id
}
