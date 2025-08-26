# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }
resource "azurerm_network_interface" "nic" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  dns_servers                   = var.dns_servers
  edge_zone                     = var.edge_zone
#   enable_ip_forwarding          = var.ip_forwarding_enabled
#   enable_accelerated_networking = var.accelerated_networking_enabled
  internal_dns_name_label       = var.internal_dns_name_label
  tags                          = var.tags

  ip_configuration {
    name                                    = var.ip_configuration.name
    subnet_id                               = var.ip_configuration.subnet_id
    private_ip_address_allocation           = var.ip_configuration.private_ip_address_allocation
    private_ip_address                      = var.ip_configuration.private_ip_address
    private_ip_address_version              = var.ip_configuration.private_ip_address_version
    gateway_load_balancer_frontend_ip_configuration_id = var.ip_configuration.gateway_load_balancer_frontend_ip_configuration_id
    public_ip_address_id                    = var.ip_configuration.public_ip_address_id
    primary                                 = var.ip_configuration.primary
  }

  auxiliary_mode = var.auxiliary_mode
  auxiliary_sku  = var.auxiliary_sku
}
