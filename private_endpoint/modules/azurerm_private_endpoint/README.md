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
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | Custom name for the network interface | `string` | `null` | no |
| <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations) | Optional static IP configurations | <pre>list(object({<br>    name               = string<br>    private_ip_address = string<br>    subresource_name   = optional(string)<br>    member_name        = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region where the Private Endpoint should exist | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the Name of the Private Endpoint | `string` | n/a | yes |
| <a name="input_private_dns_zone_group"></a> [private\_dns\_zone\_group](#input\_private\_dns\_zone\_group) | A block specifying private DNS zone group configuration | <pre>object({<br>    name                  = string<br>    private_dns_zone_ids  = list(string)<br>  })</pre> | `null` | no |
| <a name="input_private_service_connection"></a> [private\_service\_connection](#input\_private\_service\_connection) | The private service connection configuration | <pre>object({<br>    name                           = string<br>    is_manual_connection           = bool<br>    private_connection_resource_id = optional(string)<br>    private_connection_resource_alias = optional(string)<br>    subresource_names              = optional(list(string))<br>    request_message                = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the Name of the Resource Group | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet for the Private Endpoint | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_dns_configs"></a> [custom\_dns\_configs](#output\_custom\_dns\_configs) | The custom DNS configurations for the private endpoint |
| <a name="output_ip_configurations"></a> [ip\_configurations](#output\_ip\_configurations) | The IP configurations for the private endpoint |
| <a name="output_network_interface"></a> [network\_interface](#output\_network\_interface) | The network interface associated with the private endpoint |
| <a name="output_private_dns_zone_configs"></a> [private\_dns\_zone\_configs](#output\_private\_dns\_zone\_configs) | The private DNS zone configurations for the private endpoint |
| <a name="output_private_endpoint_id"></a> [private\_endpoint\_id](#output\_private\_endpoint\_id) | The ID of the Private Endpoint |
