###############################################
# Azure Private Endpoint Terraform Module
# Compliant with HP Runway Standards
# - Enforces private connectivity to Azure PaaS services
# - Requires tagging for governance
# - Supports DNS zone linking
# - Supports RBAC-first approach
# - Supports custom NIC name for consistency
###############################################

# ---------------------------
# Provider Configuration
# ---------------------------
# The provider block should be declared at root module level, not inside this resource module.
# Example (commented out here for reference):
#
# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

# ---------------------------
# Azure Private Endpoint Resource
# ---------------------------
resource "azurerm_private_endpoint" "private_endpoint" {
  # Name of the Private Endpoint
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Subnet in which the Private Endpoint will be created.
  # IMPORTANT: The subnet must have private endpoint policies disabled.
  subnet_id = var.subnet_id

  # Governance: All resources must have tags (env, app, owner, cost_center, etc.)
  tags = var.tags

  # Optional: Provide a custom NIC name. If null, Azure will auto-generate one.
  custom_network_interface_name = var.custom_network_interface_name != null ? var.custom_network_interface_name : null

  # ---------------------------
  # DNS Zone Group (Optional)
  # ---------------------------
  # Allows linking the Private Endpoint to one or more Private DNS Zones
  # for automatic DNS resolution inside the VNET.
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group != null ? [var.private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  # ---------------------------
  # Private Service Connection (Required)
  # ---------------------------
  # Defines the actual connection between the Private Endpoint and the target Azure service.
  private_service_connection {
    name                             = var.private_service_connection.name
    is_manual_connection             = var.private_service_connection.is_manual_connection # True for approval workflow
    private_connection_resource_id   = var.private_service_connection.private_connection_resource_id
    private_connection_resource_alias = var.private_service_connection.private_connection_resource_alias

    # Subresources (e.g., blob, table for storage accounts, sqlServer for SQL, vault for Key Vault)
    subresource_names = try(var.private_service_connection.subresource_names, null)

    # Optional request message for manual approval scenarios
    request_message = try(var.private_service_connection.request_message, null)
  }

  # ---------------------------
  # IP Configurations (Optional)
  # ---------------------------
  # Allows specifying static private IPs instead of relying on Azure auto-assignment.
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
