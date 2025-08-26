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
| [azurerm_web_application_firewall_policy.waf](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/web_application_firewall_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | Timeout for creating the Web Application Firewall Policy. | `string` | `"30m"` | no |
| <a name="input_custom_rules"></a> [custom\_rules](#input\_custom\_rules) | One or more custom\_rules blocks. | <pre>list(object({<br>    enabled              = optional(bool, true)<br>    name                 = optional(string)<br>    priority             = number<br>    rule_type            = string<br>    match_conditions     = list(object({<br>      match_variables    = list(object({<br>        variable_name    = string<br>        selector         = optional(string)<br>      }))<br>      match_values       = optional(list(string))<br>      operator           = string<br>      negation_condition = optional(bool)<br>      transforms         = optional(list(string))<br>    }))<br>    action               = string<br>    rate_limit_duration  = optional(string)<br>    rate_limit_threshold = optional(number)<br>    group_rate_limit_by  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | Timeout for deleting the Web Application Firewall Policy. | `string` | `"30m"` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource location. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_managed_rules"></a> [managed\_rules](#input\_managed\_rules) | A managed\_rules block. | <pre>object({<br>    exclusion = optional(list(object({<br>      match_variable           = string<br>      selector                 = string<br>      selector_match_operator  = string<br>      excluded_rule_set        = optional(list(object({<br>        type                   = optional(string, "OWASP")<br>        version                = optional(string, "3.2")<br>        rule_group             = optional(list(object({<br>          rule_group_name      = string<br>          excluded_rules       = optional(list(number))<br>        })))<br>      })))<br>    })))<br>    managed_rule_set = list(object({<br>      type                    = optional(string, "OWASP")<br>      version                 = string<br>      rule_group_override     = optional(list(object({<br>        rule_group_name       = string<br>        rule                  = optional(list(object({<br>          id                  = number<br>          enabled             = optional(bool, false)<br>          action              = optional(string)<br>        })))<br>      })))<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_policy_settings"></a> [policy\_settings](#input\_policy\_settings) | A policy\_settings block. | <pre>object({<br>    enabled                               = optional(bool, true)<br>    mode                                  = optional(string, "Prevention")<br>    file_upload_limit_in_mb               = optional(number, 100)<br>    request_body_check                    = optional(bool, true)<br>    max_request_body_size_in_kb           = optional(number, 128)<br>    log_scrubbing                         = optional(object({<br>      enabled                             = optional(bool, true)<br>      rule                                = optional(list(object({<br>        enabled                          = optional(bool, true)<br>        match_variable                   = string<br>        selector_match_operator          = optional(string, "Equals")<br>        selector                         = optional(string)<br>      })))<br>    }))<br>    request_body_enforcement              = optional(bool, true)<br>    request_body_inspect_limit_in_kb      = optional(number, 128)<br>    js_challenge_cookie_expiration_in_minutes = optional(number, 30)<br>    file_upload_enforcement               = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_read_timeout"></a> [read\_timeout](#input\_read\_timeout) | Timeout for reading the Web Application Firewall Policy. | `string` | `"5m"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Subscription ID where the Web Application Firewall Policy should exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the Web Application Firewall Policy. | `map(string)` | `{}` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | Timeout for updating the Web Application Firewall Policy. | `string` | `"30m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_http_listener_ids"></a> [http\_listener\_ids](#output\_http\_listener\_ids) | A list of HTTP Listener IDs from an azurerm\_application\_gateway. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Web Application Firewall Policy. |
| <a name="output_path_based_rule_ids"></a> [path\_based\_rule\_ids](#output\_path\_based\_rule\_ids) | A list of URL Path Map Path Rule IDs from an azurerm\_application\_gateway. |
