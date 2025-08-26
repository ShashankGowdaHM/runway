# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }
resource "azurerm_application_gateway" "application_gateway" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = lookup(var.sku, "capacity", null)
  }

  fips_enabled = var.fips_enabled

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name       = backend_address_pool.value.name
      fqdns      = lookup(backend_address_pool.value, "fqdns", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", null)
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                             = backend_http_settings.value.name
      cookie_based_affinity            = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name             = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      path                             = lookup(backend_http_settings.value, "path", null)
      port                             = backend_http_settings.value.port
      probe_name                      = lookup(backend_http_settings.value, "probe_name", null)
      protocol                        = backend_http_settings.value.protocol
      request_timeout                 = lookup(backend_http_settings.value, "request_timeout", null)
      host_name                      = lookup(backend_http_settings.value, "host_name", null)
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)

      dynamic "authentication_certificate" {
        for_each = lookup(backend_http_settings.value, "authentication_certificate", [])
        content {
          name = authentication_certificate.value.name
        }
      }

      trusted_root_certificate_names = lookup(backend_http_settings.value, "trusted_root_certificate_names", null)

      connection_draining {
        enabled         = lookup(backend_http_settings.value.connection_draining, "enabled", false)
        drain_timeout_sec = lookup(backend_http_settings.value.connection_draining, "drain_timeout_sec", 0)
      }
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.frontend_ip_configurations
    content {
      name                      = frontend_ip_configuration.value.name
      subnet_id                 = lookup(frontend_ip_configuration.value, "subnet_id", null)
      private_ip_address        = lookup(frontend_ip_configuration.value, "private_ip_address", null)
      public_ip_address_id      = lookup(frontend_ip_configuration.value, "public_ip_address_id", null)
      private_ip_address_allocation = lookup(frontend_ip_configuration.value, "private_ip_address_allocation", null)
      private_link_configuration_name = lookup(frontend_ip_configuration.value, "private_link_configuration_name", null)
    }
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.gateway_ip_configurations
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                      = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name        = http_listener.value.frontend_port_name
      host_name                 = lookup(http_listener.value, "host_name", null)
      host_names                = lookup(http_listener.value, "host_names", null)
      protocol                  = http_listener.value.protocol
      require_sni               = lookup(http_listener.value, "require_sni", false)
      ssl_certificate_name      = lookup(http_listener.value, "ssl_certificate_name", null)
      firewall_policy_id        = lookup(http_listener.value, "firewall_policy_id", null)
      ssl_profile_name          = lookup(http_listener.value, "ssl_profile_name", null)
      # custom_error_configuration can be added similarly if needed
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      http_listener_name          = request_routing_rule.value.http_listener_name
      backend_address_pool_name   = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name  = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
      priority                    = lookup(request_routing_rule.value, "priority", null)
    }
  }

  dynamic "global" {
    for_each = var.global == null ? [] : [var.global]
    content {
      request_buffering_enabled  = global.value.request_buffering_enabled
      response_buffering_enabled = global.value.response_buffering_enabled
    }
  }

  dynamic "identity" {
    for_each = var.identity == null ? [] : [var.identity]
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  tags = var.tags
}
