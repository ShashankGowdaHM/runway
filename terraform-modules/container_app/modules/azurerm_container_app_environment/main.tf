# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_container_app_environment" "manenv" {
  name                                 = var.name
  location                             = var.location
  resource_group_name                  = var.resource_group_name
  dapr_application_insights_connection_string = var.dapr_application_insights_connection_string
  infrastructure_resource_group_name   = var.infrastructure_resource_group_name
  infrastructure_subnet_id            = var.infrastructure_subnet_id
  internal_load_balancer_enabled      = var.internal_load_balancer_enabled
  zone_redundancy_enabled             = var.zone_redundancy_enabled
  log_analytics_workspace_id          = var.log_analytics_workspace_id
  # logs_destination                    = var.logs_destination
  mutual_tls_enabled                  = var.mutual_tls_enabled
  tags                                = var.tags

  dynamic "workload_profile" {
    for_each = var.workload_profiles != null ? var.workload_profiles : []
    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.workload_profile_type
      maximum_count         = workload_profile.value.maximum_count
      minimum_count         = workload_profile.value.minimum_count
    }
  }
}