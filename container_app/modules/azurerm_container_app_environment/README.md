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
| [azurerm_container_app_environment.manenv](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/container_app_environment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dapr_application_insights_connection_string"></a> [dapr\_application\_insights\_connection\_string](#input\_dapr\_application\_insights\_connection\_string) | Application Insights connection string used by Dapr to export telemetry. | `string` | `null` | no |
| <a name="input_infrastructure_resource_group_name"></a> [infrastructure\_resource\_group\_name](#input\_infrastructure\_resource\_group\_name) | Platform-managed resource group for hosting infrastructure resources. | `string` | `null` | no |
| <a name="input_infrastructure_subnet_id"></a> [infrastructure\_subnet\_id](#input\_infrastructure\_subnet\_id) | The existing Subnet to use for the Container Apps Control Plane. | `string` | `null` | no |
| <a name="input_internal_load_balancer_enabled"></a> [internal\_load\_balancer\_enabled](#input\_internal\_load\_balancer\_enabled) | Should the Container Environment operate in Internal Load Balancing Mode? | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the Container App Environment is to exist. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to. | `string` | `null` | no |
| <a name="input_logs_destination"></a> [logs\_destination](#input\_logs\_destination) | Where the application logs will be saved. | `string` | `null` | no |
| <a name="input_mutual_tls_enabled"></a> [mutual\_tls\_enabled](#input\_mutual\_tls\_enabled) | Should mutual TLS be enabled? | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Container Apps Managed Environment. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Container App Environment is to be created. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID in which the Container App Environment is created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_workload_profiles"></a> [workload\_profiles](#input\_workload\_profiles) | List of workload profiles. | <pre>list(object({<br>    name                  = string<br>    workload_profile_type = string<br>    minimum_count         = number<br>    maximum_count         = number<br>  }))</pre> | `[]` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Should the Container App Environment be created with Zone Redundancy enabled? | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_domain_verification_id"></a> [custom\_domain\_verification\_id](#output\_custom\_domain\_verification\_id) | The ID of the Custom Domain Verification. |
| <a name="output_default_domain"></a> [default\_domain](#output\_default\_domain) | The default publicly resolvable name of this Container App Environment. |
| <a name="output_docker_bridge_cidr"></a> [docker\_bridge\_cidr](#output\_docker\_bridge\_cidr) | The network addressing in which the Container Apps will reside in CIDR notation. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Container App Environment. |
| <a name="output_platform_reserved_cidr"></a> [platform\_reserved\_cidr](#output\_platform\_reserved\_cidr) | The IP range reserved for infrastructure. |
| <a name="output_platform_reserved_dns_ip_address"></a> [platform\_reserved\_dns\_ip\_address](#output\_platform\_reserved\_dns\_ip\_address) | The reserved IP address for the internal DNS server. |
| <a name="output_static_ip_address"></a> [static\_ip\_address](#output\_static\_ip\_address) | The Static IP address of the Environment. |
<!-- END_TF_DOCS -->