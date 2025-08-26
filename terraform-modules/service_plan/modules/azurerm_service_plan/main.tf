# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_service_plan" "service_plan" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  app_service_environment_id   = var.app_service_environment_id != null ? var.app_service_environment_id : null
  maximum_elastic_worker_count = var.maximum_elastic_worker_count != null ? var.maximum_elastic_worker_count : null
  worker_count                 = var.worker_count != null ? var.worker_count : null
  per_site_scaling_enabled     = var.per_site_scaling_enabled != null ? var.per_site_scaling_enabled : false
  zone_balancing_enabled       = var.zone_balancing_enabled != null ? var.zone_balancing_enabled : false


  tags = var.tags

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    read   = var.read_timeout
    delete = var.delete_timeout
  }
}