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
| [azurerm_key_vault.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/key_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_policy"></a> [access\_policy](#input\_access\_policy) | A list of access\_policy objects (up to 1024) describing access policies. | <pre>list(object({<br>    tenant_id               = string<br>    object_id               = string<br>    application_id          = optional(string)<br>    certificate_permissions = optional(list(string))<br>    key_permissions         = optional(list(string))<br>    secret_permissions      = optional(list(string))<br>    storage_permissions     = optional(list(string))<br>  }))</pre> | `[]` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | One or more contact block. | <pre>list(object({<br>    email = string<br>    name  = optional(string)<br>    phone = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | Timeout for creating the Web Application Firewall Policy. | `string` | `"30m"` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | Timeout for deleting the Web Application Firewall Policy. | `string` | `"30m"` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `false` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the Key Vault. Changing this forces a new resource to be created. The name must be globally unique. If the vault is in a recoverable state then the vault will need to be purged before reusing the name. | `string` | n/a | yes |
| <a name="input_network_acls"></a> [network\_acls](#input\_network\_acls) | A network\_acls block. | <pre>object({<br>    bypass                     = string<br>    default_action             = string<br>    ip_rules                   = optional(list(string))<br>    virtual_network_subnet_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this Key Vault. Defaults to true. | `bool` | `true` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Is Purge Protection enabled for this Key Vault? | `bool` | `false` | no |
| <a name="input_read_timeout"></a> [read\_timeout](#input\_read\_timeout) | Timeout for reading the Web Application Firewall Policy. | `string` | `"5m"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | n/a | yes |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days. | `number` | `90` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Subscription Id where the Key Vault should exist. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | `string` | n/a | yes |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | Timeout for updating the Web Application Firewall Policy. | `string` | `"30m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Key Vault. |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
