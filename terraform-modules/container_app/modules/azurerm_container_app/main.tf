# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_container_app" "container_app" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode
  workload_profile_name        = var.workload_profile_name
  max_inactive_revisions       = var.max_inactive_revisions
  tags                         = var.tags

  dynamic "template" {
    for_each = var.template != null ? [var.template] : []
    content {
      dynamic "init_container" {
        for_each = try(template.value.init_containers, [])
        content {
          name  = init_container.value.name
          image = init_container.value.image
          args  = lookup(init_container.value, "args", null)
          command = lookup(init_container.value, "command", null)
          cpu    = lookup(init_container.value, "cpu", null)
          memory = lookup(init_container.value, "memory", null)

          dynamic "env" {
            for_each = try(init_container.value.env, [])
            content {
              name        = env.value.name
              value       = lookup(env.value, "value", null)
              secret_name = lookup(env.value, "secret_name", null)
            }
          }

          dynamic "volume_mounts" {
            for_each = try(init_container.value.volume_mounts, [])
            content {
              name     = volume_mounts.value.name
              path     = volume_mounts.value.path
            }
          }
        }
      }

      container {
        name   = template.value.container.name
        image  = template.value.container.image
        args   = lookup(template.value.container, "args", null)
        command = lookup(template.value.container, "command", null)
        cpu    = lookup(template.value.container, "cpu", null)
        memory = lookup(template.value.container, "memory", null)

        dynamic "env" {
          for_each = lookup(template.value.container, "env", [])
          content {
            name        = env.value.name
            value       = lookup(env.value, "value", null)
            secret_name = lookup(env.value, "secret_name", null)
          }
        }

        dynamic "liveness_probe" {
          for_each = lookup(template.value.container, "liveness_probe", null) != null ? [template.value.container.liveness_probe] : []
          content {
            path                  = liveness_probe.value.path
            port                  = liveness_probe.value.port
            transport             = liveness_probe.value.transport
            failure_count_threshold = lookup(liveness_probe.value, "failure_count_threshold", 3)
            host                  = lookup(liveness_probe.value, "host", null)
            initial_delay         = lookup(liveness_probe.value, "initial_delay", 1)
            interval_seconds      = lookup(liveness_probe.value, "interval_seconds", 10)
            timeout               = lookup(liveness_probe.value, "timeout", 1)

            dynamic "header" {
              for_each = lookup(liveness_probe.value, "header", null) != null ? [liveness_probe.value.header] : []
              content {
                name  = header.value.name
                value = header.value.value
              }
            }
          }
        }

        dynamic "readiness_probe" {
          for_each = lookup(template.value.container, "readiness_probe", null) != null ? [template.value.container.readiness_probe] : []
          content {
            path                  = readiness_probe.value.path
            port                  = readiness_probe.value.port
            transport             = readiness_probe.value.transport
            failure_count_threshold = lookup(readiness_probe.value, "failure_count_threshold", 3)
            success_count_threshold = lookup(readiness_probe.value, "success_count_threshold", 3)
            timeout               = lookup(readiness_probe.value, "timeout", 1)

            dynamic "header" {
              for_each = lookup(readiness_probe.value, "header", null) != null ? [readiness_probe.value.header] : []
              content {
                name  = header.value.name
                value = header.value.value
              }
            }
          }
        }

        dynamic "startup_probe" {
          for_each = lookup(template.value.container, "startup_probe", null) != null ? [template.value.container.startup_probe] : []
          content {
            path      = startup_probe.value.path
            port      = startup_probe.value.port
            transport = startup_probe.value.transport
            failure_count_threshold = lookup(startup_probe.value, "failure_count_threshold", 3)
            timeout   = lookup(startup_probe.value, "timeout", 1)
          }
        }

        dynamic "volume_mounts" {
          for_each = lookup(template.value.container, "volume_mounts", [])
          content {
            name     = volume_mounts.value.name
            path     = volume_mounts.value.path
          }
        }
      }

      min_replicas = lookup(template.value, "min_replicas", null)
      max_replicas = lookup(template.value, "max_replicas", null)

      revision_suffix = lookup(template.value, "revision_suffix", null)

      http_scale_rule {
        name = template.value.http_scale_rule.name
        concurrent_requests = template.value.http_scale_rule.concurrent_requests
        dynamic "authentication" {
          for_each = lookup(template.value.http_scale_rule, "authentication", null) != null ? [1] : []
          content {
            secret_name = template.value.http_scale_rule.authentication.secret_name
            trigger_parameter = template.value.http_scale_rule.authentication.trigger_parameter
          }
        }
      }

      dynamic "volume" {
        for_each = lookup(template.value, "volume", [])
        content {
          name         = volume.value.name
          storage_name = lookup(volume.value, "storage_name", null)
          storage_type = lookup(volume.value, "storage_type", "EmptyDir")
        }
      }
    }
  }

  dynamic "secret" {
    for_each = var.secret
    content {
      name                = secret.value.name
      identity            = lookup(secret.value, "identity", null)
      key_vault_secret_id = lookup(secret.value, "key_vault_secret_id", null)
      value               = lookup(secret.value, "value", null)
    }
  }

  dynamic "dapr" {
    for_each = var.dapr != null ? [var.dapr] : []
    content {
      app_id       = var.dapr.app_id
      app_port     = lookup(var.dapr, "app_port", null)
      app_protocol = lookup(var.dapr, "app_protocol", "http")
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = var.identity.type
      identity_ids = lookup(var.identity, "identity_ids", null)
    }
  }

  dynamic "ingress" {
    for_each = var.ingress != null ? [var.ingress] : []
    content {
      external_enabled           = var.ingress.external_enabled
      allow_insecure_connections = lookup(var.ingress, "allow_insecure_connections", false)
      fqdn                       = lookup(var.ingress, "fqdn", null)
      target_port                = var.ingress.target_port
      exposed_port               = lookup(var.ingress, "exposed_port", null)
      transport                  = lookup(var.ingress, "transport", "auto")

      dynamic "ip_security_restriction" {
        for_each = try(var.ingress.ip_security_restriction, [])
        content {
          name             = ip_security_restriction.value.name
          action           = ip_security_restriction.value.action
          description      = lookup(ip_security_restriction.value, "description", null)
          ip_address_range = ip_security_restriction.value.ip_address_range
        }
      }

      dynamic "traffic_weight" {
        for_each = try(var.ingress.traffic_weight, [])
        content {
          percentage       = traffic_weight.value.percentage
          label           = lookup(traffic_weight.value, "label", null)
          latest_revision = lookup(traffic_weight.value, "latest_revision", false)
          revision_suffix = lookup(traffic_weight.value, "revision_suffix", null)
        }
      }
    }
  }

  registry {
    server   = var.registry.server
    username = var.registry.username
    password_secret_name = var.registry.password_secret_name
  }
}
