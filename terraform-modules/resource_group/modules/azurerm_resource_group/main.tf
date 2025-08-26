# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags     = var.tags
}