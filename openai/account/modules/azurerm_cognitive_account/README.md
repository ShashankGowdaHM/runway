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
| [azurerm_cognitive_account.model_account](https://registry.terraform.io/providers/hashicorp/azurerm/4.2.0/docs/resources/cognitive_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | The name of the Cognitive Account | `string` | n/a | yes |
| <a name="input_custom_question_answering_search_service_id"></a> [custom\_question\_answering\_search\_service\_id](#input\_custom\_question\_answering\_search\_service\_id) | If kind is TextAnalytics this specifies the ID of the Search service | `string` | `""` | no |
| <a name="input_custom_question_answering_search_service_key"></a> [custom\_question\_answering\_search\_service\_key](#input\_custom\_question\_answering\_search\_service\_key) | If kind is TextAnalytics this specifies the key of the Search service | `string` | `""` | no |
| <a name="input_custom_subdomain_name"></a> [custom\_subdomain\_name](#input\_custom\_subdomain\_name) | The custom subdomain name of the Cognitive Account | `string` | `""` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | A customer\_managed\_key block | <pre>object({<br>    key_vault_key_id   = string<br>    identity_client_id = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_dynamic_throttling_enabled"></a> [dynamic\_throttling\_enabled](#input\_dynamic\_throttling\_enabled) | Whether to enable the dynamic throttling for this Cognitive Service Account | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | An identity block | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of the Cognitive Account | `string` | `"OpenAI"` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | Whether local authentication methods are enabled for the Cognitive Account | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the Cognitive Account | `string` | n/a | yes |
| <a name="input_metrics_advisor_aad_client_id"></a> [metrics\_advisor\_aad\_client\_id](#input\_metrics\_advisor\_aad\_client\_id) | The Azure AD Client ID (Application ID) for Metrics Advisor | `string` | `""` | no |
| <a name="input_metrics_advisor_aad_tenant_id"></a> [metrics\_advisor\_aad\_tenant\_id](#input\_metrics\_advisor\_aad\_tenant\_id) | The Azure AD Tenant ID for Metrics Advisor | `string` | `""` | no |
| <a name="input_metrics_advisor_super_user_name"></a> [metrics\_advisor\_super\_user\_name](#input\_metrics\_advisor\_super\_user\_name) | The super user of Metrics Advisor | `string` | `""` | no |
| <a name="input_metrics_advisor_website_name"></a> [metrics\_advisor\_website\_name](#input\_metrics\_advisor\_website\_name) | The website name of Metrics Advisor | `string` | `""` | no |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | A network\_acls block | <pre>object({<br>    default_action = string<br>    ip_rules       = optional(list(string))<br>    virtual_network_rules = optional(list(object({<br>      subnet_id                            = string<br>      ignore_missing_vnet_service_endpoint = optional(bool, false)<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_outbound_network_access_restricted"></a> [outbound\_network\_access\_restricted](#input\_outbound\_network\_access\_restricted) | Whether outbound network access is restricted for the Cognitive Account | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for the Cognitive Account | `bool` | `true` | no |
| <a name="input_qna_runtime_endpoint"></a> [qna\_runtime\_endpoint](#input\_qna\_runtime\_endpoint) | A URL to link a QnAMaker cognitive account to a QnA runtime | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Cognitive Account | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The SKU name of the Cognitive Account | `string` | `"S0"` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | A storage block | <pre>object({<br>    storage_account_id = string<br>    identity_client_id = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription id where the openai deployment is created | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cognitive_account_id"></a> [cognitive\_account\_id](#output\_cognitive\_account\_id) | The ID of the Cognitive Account |
| <a name="output_cognitive_account_kind"></a> [cognitive\_account\_kind](#output\_cognitive\_account\_kind) | The kind of the Cognitive Account |
| <a name="output_cognitive_account_name"></a> [cognitive\_account\_name](#output\_cognitive\_account\_name) | The name of the Cognitive Account |
