# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_subnet" "subnet" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

  dynamic "delegation" {
    for_each = var.delegation != null ? [var.delegation] : []
    content {
      name = delegation.value.name

      dynamic "service_delegation" {
        for_each = delegation.value.service_delegation != null ? [delegation.value.service_delegation] : []
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
  default_outbound_access_enabled               = var.default_outbound_access_enabled
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
  service_endpoints                             = var.service_endpoints
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    read   = var.read_timeout
    delete = var.delete_timeout
  }
}