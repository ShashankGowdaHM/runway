# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "soa_record" {
    for_each = var.soa_record_email != null ? [1] : []
    content {
      email        = var.soa_record_email
      expire_time  = var.soa_expire_time
      minimum_ttl  = var.soa_minimum_ttl
      refresh_time = var.soa_refresh_time
      retry_time   = var.soa_retry_time
      ttl          = var.soa_ttl
    }
  }
}

