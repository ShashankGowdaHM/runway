# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  custom_network_interface_name = var.custom_network_interface_name != null ? var.custom_network_interface_name : null

  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? [var.private_dns_zone_group] : []
    content {
      name                  = private_dns_zone_group.value.name
      private_dns_zone_ids  = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  private_service_connection {
    name                           = var.private_service_connection.name
    is_manual_connection           = var.private_service_connection.is_manual_connection
    private_connection_resource_id = var.private_service_connection.private_connection_resource_id
    private_connection_resource_alias = var.private_service_connection.private_connection_resource_alias
    subresource_names              = try(var.private_service_connection.subresource_names, null)
    request_message                = try(var.private_service_connection.request_message, null)
  }

  dynamic "ip_configuration" {
    for_each = var.ip_configurations
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = try(ip_configuration.value.subresource_name, null)
      member_name        = try(ip_configuration.value.member_name, null)
    }
  }
}
