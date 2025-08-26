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
| [azurerm_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/nat_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_idle_timeout_in_minutes"></a> [idle\_timeout\_in\_minutes](#input\_idle\_timeout\_in\_minutes) | The idle timeout in minutes. Defaults to 4. | `number` | `4` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the NAT Gateway should exist. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the NAT Gateway. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Specifies the name of the Resource Group in which the NAT Gateway should exist. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU for the NAT Gateway. Defaults to 'Standard'. | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the NAT Gateway. | `map(string)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | A list of Availability Zones in which this NAT Gateway should be located. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateway_id"></a> [nat\_gateway\_id](#output\_nat\_gateway\_id) | The ID of the NAT Gateway. |
| <a name="output_nat_gateway_resource_guid"></a> [nat\_gateway\_resource\_guid](#output\_nat\_gateway\_resource\_guid) | The resource GUID of the NAT Gateway. |
