# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_cognitive_account" "model_account" {
  name                  = var.account_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  kind                  = var.kind
  custom_subdomain_name = var.custom_subdomain_name
  sku_name              = var.sku_name
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key != null ? [var.customer_managed_key] : []
    content {
      key_vault_key_id   = customer_managed_key.value.key_vault_key_id
      identity_client_id = lookup(customer_managed_key.value, "identity_client_id", null)
    }
  }

  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []
    content {
      default_action = network_acls.value.default_action
      ip_rules       = lookup(network_acls.value, "ip_rules", [])

      dynamic "virtual_network_rules" {
        for_each = try(network_acls.value.virtual_network_rules, [])
        content {
          subnet_id                            = virtual_network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = lookup(virtual_network_rules.value, "ignore_missing_vnet_service_endpoint", false)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", [])
    }
  }

  dynamic "storage" {
    for_each = var.storage != null ? [var.storage] : []
    content {
      storage_account_id = storage.value.storage_account_id
      identity_client_id = lookup(storage.value, "identity_client_id", null)
    }
  }

  metrics_advisor_aad_client_id                = var.kind == "MetricsAdvisor" ? var.metrics_advisor_aad_client_id : null
  metrics_advisor_aad_tenant_id                = var.kind == "MetricsAdvisor" ? var.metrics_advisor_aad_tenant_id : null
  metrics_advisor_super_user_name              = var.kind == "MetricsAdvisor" ? var.metrics_advisor_super_user_name : null
  metrics_advisor_website_name                 = var.kind == "MetricsAdvisor" ? var.metrics_advisor_website_name : null
  qna_runtime_endpoint                         = var.qna_runtime_endpoint != "" ? var.qna_runtime_endpoint : null
  custom_question_answering_search_service_id  = var.kind == "TextAnalytics" ? var.custom_question_answering_search_service_id : null
  custom_question_answering_search_service_key = var.kind == "TextAnalytics" ? var.custom_question_answering_search_service_key : null

  tags = var.tags
}