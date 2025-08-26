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
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/network_interface) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accelerated_networking_enabled"></a> [accelerated\_networking\_enabled](#input\_accelerated\_networking\_enabled) | Enable Accelerated Networking. | `bool` | `false` | no |
| <a name="input_auxiliary_mode"></a> [auxiliary\_mode](#input\_auxiliary\_mode) | Specifies the auxiliary mode for NVAs. | `string` | `null` | no |
| <a name="input_auxiliary_sku"></a> [auxiliary\_sku](#input\_auxiliary\_sku) | Specifies the auxiliary SKU for NVAs. | `string` | `null` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | A list of DNS Servers. | `list(string)` | `[]` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone. | `string` | `null` | no |
| <a name="input_internal_dns_name_label"></a> [internal\_dns\_name\_label](#input\_internal\_dns\_name\_label) | Internal DNS Name Label. | `string` | `null` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | IP Configuration block for the NIC. | <pre>object({<br>    name                                         = string<br>    subnet_id                                    = string<br>    private_ip_address_allocation                = string<br>    private_ip_address                           = optional(string)<br>    private_ip_address_version                   = optional(string)<br>    gateway_load_balancer_frontend_ip_configuration_id = optional(string)<br>    public_ip_address_id                         = optional(string)<br>    primary                                      = optional(bool)<br>  })</pre> | n/a | yes |
| <a name="input_ip_forwarding_enabled"></a> [ip\_forwarding\_enabled](#input\_ip\_forwarding\_enabled) | Enable IP Forwarding. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location where the Network Interface should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Network Interface. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the Resource Group. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_interface_applied_dns_servers"></a> [network\_interface\_applied\_dns\_servers](#output\_network\_interface\_applied\_dns\_servers) | n/a |
| <a name="output_network_interface_id"></a> [network\_interface\_id](#output\_network\_interface\_id) | n/a |
| <a name="output_network_interface_internal_domain_name_suffix"></a> [network\_interface\_internal\_domain\_name\_suffix](#output\_network\_interface\_internal\_domain\_name\_suffix) | n/a |
| <a name="output_network_interface_mac_address"></a> [network\_interface\_mac\_address](#output\_network\_interface\_mac\_address) | n/a |
| <a name="output_network_interface_private_ip"></a> [network\_interface\_private\_ip](#output\_network\_interface\_private\_ip) | n/a |
| <a name="output_network_interface_private_ips"></a> [network\_interface\_private\_ips](#output\_network\_interface\_private\_ips) | n/a |
| <a name="output_network_interface_virtual_machine_id"></a> [network\_interface\_virtual\_machine\_id](#output\_network\_interface\_virtual\_machine\_id) | n/a |
