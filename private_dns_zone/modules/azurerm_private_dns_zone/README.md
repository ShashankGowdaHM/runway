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
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/private_dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the Private DNS Zone. Must be a valid domain name. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the resource group where the Private DNS Zone will be created. | `string` | n/a | yes |
| <a name="input_soa_expire_time"></a> [soa\_expire\_time](#input\_soa\_expire\_time) | The expire time for the SOA record. | `number` | `2419200` | no |
| <a name="input_soa_minimum_ttl"></a> [soa\_minimum\_ttl](#input\_soa\_minimum\_ttl) | The minimum TTL for the SOA record. | `number` | `10` | no |
| <a name="input_soa_record_email"></a> [soa\_record\_email](#input\_soa\_record\_email) | The email contact for the SOA record. | `string` | `null` | no |
| <a name="input_soa_refresh_time"></a> [soa\_refresh\_time](#input\_soa\_refresh\_time) | The refresh time for the SOA record. | `number` | `3600` | no |
| <a name="input_soa_retry_time"></a> [soa\_retry\_time](#input\_soa\_retry\_time) | The retry time for the SOA record. | `number` | `300` | no |
| <a name="input_soa_ttl"></a> [soa\_ttl](#input\_soa\_ttl) | The TTL for the SOA record. | `number` | `3600` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_max_number_of_record_sets"></a> [max\_number\_of\_record\_sets](#output\_max\_number\_of\_record\_sets) | The maximum number of record sets that can be created. |
| <a name="output_max_virtual_network_links"></a> [max\_virtual\_network\_links](#output\_max\_virtual\_network\_links) | The maximum number of virtual network links. |
| <a name="output_max_vnet_links_with_registration"></a> [max\_vnet\_links\_with\_registration](#output\_max\_vnet\_links\_with\_registration) | Maximum virtual network links with registration. |
| <a name="output_number_of_record_sets"></a> [number\_of\_record\_sets](#output\_number\_of\_record\_sets) | The current number of record sets in private\_dns\_zone Private DNS zone. |
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | The ID of the Private DNS Zone. |
| <a name="output_soa_record"></a> [soa\_record](#output\_soa\_record) | SOA record block. |
