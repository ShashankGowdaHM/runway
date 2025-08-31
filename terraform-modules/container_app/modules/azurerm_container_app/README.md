<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.15.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app.container_app](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/container_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_app_environment_id"></a> [container\_app\_environment\_id](#input\_container\_app\_environment\_id) | The ID of the Container App Environment. | `string` | n/a | yes |
| <a name="input_dapr"></a> [dapr](#input\_dapr) | The Dapr configuration for the Container App. | <pre>object({<br>    app_id   = string<br>    app_port = optional(number) # The port which the application is listening on. This is the same as the ingress port.<br>    app_protocol = optional(string, "http") # The protocol used by the application. Default is http.<br>  })</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | The identity configuration. | <pre>object({<br>    type         = string # The type of managed identity to assign. Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned (to enable both).<br>    identity_ids = optional(list(string), null)<br>  })</pre> | `null` | no |
| <a name="input_ingress"></a> [ingress](#input\_ingress) | The ingress configuration. | <pre>object({<br>    allow_insecure_connections = optional(bool, false) # Allow insecure connections<br>    fqdn = optional(string) # Fully qualified domain name<br>    external_enabled  = optional(bool, false) # Enable external access<br>    ip_security_restriction = optional(list(object({<br>      name    = string<br>      action  = string<br>      description = optional(string)<br>      ip_address_range = string<br>    })), [])<br>    target_port       = number<br>    exposed_port     = optional(number) # Port to expose. can only be specified when transport is set to tcp<br>    traffic_weight = list(object({<br>      label            = optional(string)<br>      latest_revision   = optional(bool, false) # Ensure this is always available<br>      revision_suffix   = optional(string) # Optional revision identifier<br>      percentage        = number<br>    }))<br>    transport        = optional(string, "auto") # The transport protocol. Default is auto.<br>    client_certificate_mode = optional(string) # The client certificate mode. Possible values are require, accept, and ignore.<br>  })</pre> | `null` | no |
| <a name="input_max_inactive_revisions"></a> [max\_inactive\_revisions](#input\_max\_inactive\_revisions) | Maximum number of inactive revisions. | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container App. | `string` | n/a | yes |
| <a name="input_registry"></a> [registry](#input\_registry) | The container registry configuration. | <pre>object({<br>    server               = string<br>    identity            = optional(string)<br>    username             = optional(string)<br>    password_secret_name = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_revision_mode"></a> [revision\_mode](#input\_revision\_mode) | The revision mode of the Container App. | `string` | `"Single"` | no |
| <a name="input_secret"></a> [secret](#input\_secret) | Secrets for the Container App. | <pre>list(object({<br>    name                = string<br>    identity            = optional(string)<br>    key_vault_secret_id = optional(string)<br>    value               = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the Container App. | `map(string)` | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | The template configuration for the Container App. | <pre>object({<br>    init_containers = optional(list(object({<br>      name            = string<br>      image           = string<br>      args            = optional(list(string))<br>      command         = optional(list(string))<br>      cpu             = optional(number)<br>      memory          = optional(string) # should be twice the value of cpu<br>      env             = optional(list(object({<br>        name        = string<br>        value       = optional(string)<br>        secret_name = optional(string)<br>      })), [])<br>      volume_mounts   = optional(list(object({<br>        name      = string<br>        path      = string<br>        sub_path  = optional(string)<br>      })), [])<br>    })), [])<br><br>    container = object({<br>      args            = optional(list(string))<br>      command         = optional(list(string))<br>      name   = string<br>      image  = string<br>      cpu             = optional(number)<br>      memory          = optional(string) # should be twice the value of cpu<br>      env             = optional(list(object({<br>        name        = string<br>        value       = optional(string)<br>        secret_name = optional(string)<br>      })), [])<br>      liveness_probe = optional(object({<br>      failure_count_threshold = optional(number, 3)<br>      header = optional(object({<br>        name  = string<br>        value = string<br>      }), null)<br>      host     = optional(string)<br>      inital_delay = optional(number, 1)<br>      interval_seconds = optional(number, 10)<br>      path      = optional(string)<br>      port      = number<br>      timeout = optional(number, 1)<br>      transport = string # Required field<br>    }), null)<br>    readiness_probe = optional(object({<br>      failure_count_threshold = optional(number, 3)<br>      header = optional(object({<br>        name  = string<br>        value = string<br>      }), null)<br>      host     = optional(string)<br>      inital_delay = optional(number, 1)<br>      interval_seconds = optional(number, 10)<br>      path      = optional(string)<br>      port      = number<br>      success_count_threshold = optional(number, 3)<br>      timeout = optional(number, 1)<br>      transport = string # Required field<br>    }), null)<br>    startup_probe = optional(object({<br>      failure_count_threshold = optional(number, 3)<br>      header = optional(object({<br>        name  = string<br>        value = string<br>      }), null)<br>      host     = optional(string)<br>      inital_delay = optional(number, 1)<br>      interval_seconds = optional(number, 10)<br>      path      = optional(string)<br>      port      = number<br>      timeout = optional(number, 1)<br>      transport = string # Required field<br>    }), null)<br>    volume_mounts   = optional(list(object({<br>        name      = string<br>        path      = string<br>        sub_path  = optional(string)<br>      })), [])<br>    })<br><br>    min_replicas = optional(number, null)<br>    max_replicas = optional(number, null)<br>    azure_queue_scale_rule = optional(object({<br>      queue_name = string<br>      queue_length = number<br>      name = string<br>      authentication = object({<br>        secret_name = string<br>        trigger_parameter = string<br>      })<br>    }), null)<br>    custom_scale_rule = optional(object({<br>      name = string<br>      custom_rule_type = string<br>      metadata = map(string)<br>      authentication = optional(object({<br>        secret_name = string<br>        trigger_parameter = string<br>      }), null)<br>    }), null)<br>    http_scale_rule = optional(object({<br>      concurrent_requests = string<br>      name                = string<br>      authentication = optional(object({<br>        secret_name = string<br>        trigger_parameter = string<br>      }), null)<br>    }), null)<br>    tcp_scale_rule = optional(object({<br>      concurrent_requests = string<br>      name                = string<br>      authentication = optional(object({<br>        secret_name = string<br>        trigger_parameter = string<br>      }), null)<br>    }), null)<br>    revision_suffix = optional(string) # Optional revision identifier<br>    volume = optional(list(object({<br>      name = string<br>      storage_name = optional(string)<br>      storage_type = optional(string, "EmptyDir")<br>    })), [])<br>    <br>  })</pre> | n/a | yes |
| <a name="input_workload_profile_name"></a> [workload\_profile\_name](#input\_workload\_profile\_name) | The workload profile name. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_app_id"></a> [container\_app\_id](#output\_container\_app\_id) | The ID of the Container App. |
| <a name="output_container_app_name"></a> [container\_app\_name](#output\_container\_app\_name) | The name of the Container App. |
| <a name="output_container_app_url"></a> [container\_app\_url](#output\_container\_app\_url) | The default URL of the Container App. |
<!-- END_TF_DOCS -->