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
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocation_method"></a> [allocation\_method](#input\_allocation\_method) | Defines the allocation method for this IP address. Possible values are Static or Dynamic. | `string` | n/a | yes |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | Timeout for creating the Public IP | `string` | `"30m"` | no |
| <a name="input_ddos_protection_mode"></a> [ddos\_protection\_mode](#input\_ddos\_protection\_mode) | The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited. | `string` | `"VirtualNetworkInherited"` | no |
| <a name="input_ddos_protection_plan_id"></a> [ddos\_protection\_plan\_id](#input\_ddos\_protection\_plan\_id) | The ID of DDoS protection plan associated with the public IP. Can only be set when ddos\_protection\_mode is Enabled. | `string` | `null` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | Timeout for deleting the Public IP | `string` | `"30m"` | no |
| <a name="input_domain_name_label"></a> [domain\_name\_label](#input\_domain\_name\_label) | Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system. | `string` | `null` | no |
| <a name="input_domain_name_label_scope"></a> [domain\_name\_label\_scope](#input\_domain\_name\_label\_scope) | Scope for the domain name label. Possible values are NoReuse, ResourceGroupReuse, SubscriptionReuse and TenantReuse. Changing this forces a new Public IP to be created. | `string` | `null` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone within the Azure Region where this Public IP should exist. Changing this forces a new Public IP to be created. | `string` | `null` | no |
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. | `number` | `4` | no |
| <a name="input_ip_tags"></a> [ip\_tags](#input\_ip\_tags) | A mapping of IP tags to assign to the public IP. Changing this forces a new resource to be created. | `map(string)` | `{}` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created. Defaults to IPv4. | `string` | `"IPv4"` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the Public IP should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Public IP. Changing this forces a new Public IP to be created. | `string` | n/a | yes |
| <a name="input_public_ip_prefix_id"></a> [public\_ip\_prefix\_id](#input\_public\_ip\_prefix\_id) | If specified then public IP address allocated will be provided from the public IP prefix resource. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_read_timeout"></a> [read\_timeout](#input\_read\_timeout) | Timeout for reading the Public IP | `string` | `"5m"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group where this Public IP should exist. Changing this forces a new Public IP to be created. | `string` | n/a | yes |
| <a name="input_reverse_fqdn"></a> [reverse\_fqdn](#input\_reverse\_fqdn) | A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional. Changing this forces a new resource to be created. | `string` | `"Regional"` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription id where the public ip is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | Timeout for updating the Public IP | `string` | `"30m"` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The IP address value that was allocated. |
| <a name="output_public_ip_fqdn"></a> [public\_ip\_fqdn](#output\_public\_ip\_fqdn) | Fully qualified domain name of the A DNS record associated with the public IP. |
| <a name="output_public_ip_id"></a> [public\_ip\_id](#output\_public\_ip\_id) | The ID of this Public IP. |
