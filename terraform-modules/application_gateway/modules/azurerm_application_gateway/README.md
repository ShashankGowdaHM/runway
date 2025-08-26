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
| [azurerm_application_gateway.application_gateway](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/application_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_address_pools"></a> [backend\_address\_pools](#input\_backend\_address\_pools) | List of backend address pools. | <pre>list(object({<br>    name        = string<br>    fqdns       = optional(list(string))<br>    ip_addresses = optional(list(string))<br>  }))</pre> | n/a | yes |
| <a name="input_backend_http_settings"></a> [backend\_http\_settings](#input\_backend\_http\_settings) | List of backend HTTP settings. | <pre>list(object({<br>    name                             = string<br>    cookie_based_affinity            = string<br>    affinity_cookie_name             = optional(string)<br>    path                             = optional(string)<br>    port                             = number<br>    probe_name                      = optional(string)<br>    protocol                        = string<br>    request_timeout                 = optional(number)<br>    host_name                      = optional(string)<br>    pick_host_name_from_backend_address = optional(bool)<br>    authentication_certificate      = optional(list(object({ name = string })))<br>    trusted_root_certificate_names  = optional(list(string))<br>    connection_draining             = optional(object({<br>      enabled         = bool<br>      drain_timeout_sec = number<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_fips_enabled"></a> [fips\_enabled](#input\_fips\_enabled) | Is FIPS enabled on the Application Gateway? | `bool` | `false` | no |
| <a name="input_frontend_ip_configurations"></a> [frontend\_ip\_configurations](#input\_frontend\_ip\_configurations) | List of frontend IP configurations. | <pre>list(object({<br>    name                      = string<br>    subnet_id                 = optional(string)<br>    private_ip_address        = optional(string)<br>    public_ip_address_id      = optional(string)<br>    private_ip_address_allocation = optional(string)<br>    private_link_configuration_name = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_frontend_ports"></a> [frontend\_ports](#input\_frontend\_ports) | List of frontend ports. | <pre>list(object({<br>    name = string<br>    port = number<br>  }))</pre> | n/a | yes |
| <a name="input_gateway_ip_configurations"></a> [gateway\_ip\_configurations](#input\_gateway\_ip\_configurations) | List of gateway IP configurations. | <pre>list(object({<br>    name      = string<br>    subnet_id = string<br>  }))</pre> | n/a | yes |
| <a name="input_global"></a> [global](#input\_global) | Global block for request and response buffering. | <pre>object({<br>    request_buffering_enabled  = bool<br>    response_buffering_enabled = bool<br>  })</pre> | `null` | no |
| <a name="input_http_listeners"></a> [http\_listeners](#input\_http\_listeners) | List of HTTP listeners. | <pre>list(object({<br>    name                      = string<br>    frontend_ip_configuration_name = string<br>    frontend_port_name        = string<br>    host_name                 = optional(string)<br>    host_names                = optional(list(string))<br>    protocol                  = string<br>    require_sni               = optional(bool)<br>    ssl_certificate_name      = optional(string)<br>    custom_error_configuration = optional(list(object({}))) # Simplified<br>    firewall_policy_id        = optional(string)<br>    ssl_profile_name          = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | Identity block for user-assigned managed identity. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Application Gateway should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Application Gateway. | `string` | n/a | yes |
| <a name="input_request_routing_rules"></a> [request\_routing\_rules](#input\_request\_routing\_rules) | List of request routing rules. | <pre>list(object({<br>    name                        = string<br>    rule_type                   = string<br>    http_listener_name          = string<br>    backend_address_pool_name   = optional(string)<br>    backend_http_settings_name  = optional(string)<br>    redirect_configuration_name = optional(string)<br>    rewrite_rule_set_name       = optional(string)<br>    url_path_map_name           = optional(string)<br>    priority                    = optional(number)<br>  }))</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Application Gateway. | `string` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU block for the Application Gateway. | <pre>object({<br>    name     = string<br>    tier     = string<br>    capacity = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_gateway_backend_address_pools"></a> [application\_gateway\_backend\_address\_pools](#output\_application\_gateway\_backend\_address\_pools) | The backend address pools of the Application Gateway. |
| <a name="output_application_gateway_frontend_ip_configurations"></a> [application\_gateway\_frontend\_ip\_configurations](#output\_application\_gateway\_frontend\_ip\_configurations) | The frontend IP configurations of the Application Gateway. |
| <a name="output_application_gateway_http_listeners"></a> [application\_gateway\_http\_listeners](#output\_application\_gateway\_http\_listeners) | The HTTP listeners of the Application Gateway. |
| <a name="output_application_gateway_id"></a> [application\_gateway\_id](#output\_application\_gateway\_id) | The ID of the Application Gateway. |
