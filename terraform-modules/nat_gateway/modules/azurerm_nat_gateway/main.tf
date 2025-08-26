# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  sku_name                = var.sku_name
  tags                    = var.tags
  zones                   = var.zones
}

