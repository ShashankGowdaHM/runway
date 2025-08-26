# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_public_ip" "public_ip" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method

  tags = var.tags

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    read = var.read_timeout
    delete = var.delete_timeout
  }
}