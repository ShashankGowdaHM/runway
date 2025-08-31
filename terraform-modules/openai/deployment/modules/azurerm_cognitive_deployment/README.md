## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cognitive_deployment.model_deployment](https://registry.terraform.io/providers/hashicorp/azurerm/4.2.0/docs/resources/cognitive_deployment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cognitive_account_id"></a> [cognitive\_account\_id](#input\_cognitive\_account\_id) | The ID of the Cognitive Services Account | `string` | n/a | yes |
| <a name="input_model_format"></a> [model\_format](#input\_model\_format) | The format of the Cognitive Services Account Deployment model | `string` | n/a | yes |
| <a name="input_model_name"></a> [model\_name](#input\_model\_name) | The name of the Cognitive Services Account Deployment model | `string` | n/a | yes |
| <a name="input_model_version"></a> [model\_version](#input\_model\_version) | The version of the Cognitive Services Account Deployment model | `string` | `"1"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cognitive Services Account Deployment | `string` | n/a | yes |
| <a name="input_rai_policy_name"></a> [rai\_policy\_name](#input\_rai\_policy\_name) | The name of RAI policy | `string` | `null` | no |
| <a name="input_sku_capacity"></a> [sku\_capacity](#input\_sku\_capacity) | Tokens-per-Minute (TPM) capacity | `number` | `1` | no |
| <a name="input_sku_family"></a> [sku\_family](#input\_sku\_family) | The family of the SKU | `string` | `null` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The name of the SKU | `string` | n/a | yes |
| <a name="input_sku_size"></a> [sku\_size](#input\_sku\_size) | The SKU size | `string` | `null` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | The tier of the SKU | `string` | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The subscription ID for Azure | `string` | n/a | yes |
| <a name="input_version_upgrade_option"></a> [version\_upgrade\_option](#input\_version\_upgrade\_option) | Deployment model version upgrade option | `string` | `"OnceNewDefaultVersionAvailable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_deployment_id"></a> [cognitive\_deployment\_id](#output\_cognitive\_deployment\_id) | The ID of the Cognitive Deployment |
| <a name="output_cognitive_deployment_model_format"></a> [cognitive\_deployment\_model\_format](#output\_cognitive\_deployment\_model\_format) | The format of the model used in the Cognitive Deployment |
| <a name="output_cognitive_deployment_model_name"></a> [cognitive\_deployment\_model\_name](#output\_cognitive\_deployment\_model\_name) | The name of the model used in the Cognitive Deployment |
| <a name="output_cognitive_deployment_model_version"></a> [cognitive\_deployment\_model\_version](#output\_cognitive\_deployment\_model\_version) | The version of the model used in the Cognitive Deployment |
| <a name="output_cognitive_deployment_name"></a> [cognitive\_deployment\_name](#output\_cognitive\_deployment\_name) | The name of the Cognitive Deployment |
| <a name="output_cognitive_deployment_rai_policy_name"></a> [cognitive\_deployment\_rai\_policy\_name](#output\_cognitive\_deployment\_rai\_policy\_name) | The name of the RAI policy |
| <a name="output_cognitive_deployment_sku_name"></a> [cognitive\_deployment\_sku\_name](#output\_cognitive\_deployment\_sku\_name) | The SKU name of the Cognitive Deployment |
| <a name="output_cognitive_deployment_version_upgrade_option"></a> [cognitive\_deployment\_version\_upgrade\_option](#output\_cognitive\_deployment\_version\_upgrade\_option) | The version upgrade option for the Cognitive Deployment |
