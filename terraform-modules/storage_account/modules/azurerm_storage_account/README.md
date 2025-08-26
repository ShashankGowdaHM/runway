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
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/4.15.0/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2. | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa. | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | Allow or disallow nested items within this Account to opt into being public. Defaults to true. | `bool` | `true` | no |
| <a name="input_allowed_copy_scope"></a> [allowed\_copy\_scope](#input\_allowed\_copy\_scope) | Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink. | `string` | `null` | no |
| <a name="input_azure_files_authentication"></a> [azure\_files\_authentication](#input\_azure\_files\_authentication) | A azure\_files\_authentication block. | <pre>object({<br>    directory_type = string<br>    active_directory = optional(object({<br>      domain_name         = string<br>      domain_guid         = string<br>      domain_sid          = optional(string)<br>      storage_sid         = optional(string)<br>      forest_name         = optional(string)<br>      netbios_domain_name = optional(string)<br>    }))<br>    default_share_level_permission = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_blob_properties"></a> [blob\_properties](#input\_blob\_properties) | A blob\_properties block. | <pre>object({<br>    cors_rule = optional(list(object({<br>      allowed_headers    = list(string)<br>      allowed_methods    = list(string)<br>      allowed_origins    = list(string)<br>      exposed_headers    = list(string)<br>      max_age_in_seconds = number<br>    })))<br>    delete_retention_policy = optional(object({<br>      days                   = optional(number, 7)<br>      permanent_delete_enabled = optional(bool, false)<br>    }))<br>    restore_policy = optional(object({<br>      days = number<br>    }))<br>    versioning_enabled           = optional(bool, false)<br>    change_feed_enabled          = optional(bool, false)<br>    change_feed_retention_in_days = optional(number)<br>    default_service_version      = optional(string)<br>    last_access_time_enabled     = optional(bool, false)<br>    container_delete_retention_policy = optional(object({<br>      days = optional(number, 7)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | Should cross Tenant replication be enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_custom_domain"></a> [custom\_domain](#input\_custom\_domain) | A custom\_domain block. | <pre>object({<br>    name          = string<br>    use_subdomain = optional(bool)<br>  })</pre> | `null` | no |
| <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key) | A customer\_managed\_key block. | <pre>object({<br>    key_vault_key_id          = optional(string)<br>    managed_hsm_key_id        = optional(string)<br>    user_assigned_identity_id = string<br>  })</pre> | `null` | no |
| <a name="input_default_to_oauth_authentication"></a> [default\_to\_oauth\_authentication](#input\_default\_to\_oauth\_authentication) | Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false. | `bool` | `false` | no |
| <a name="input_dns_endpoint_type"></a> [dns\_endpoint\_type](#input\_dns\_endpoint\_type) | Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone) | Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created. | `string` | `null` | no |
| <a name="input_https_traffic_only_enabled"></a> [https\_traffic\_only\_enabled](#input\_https\_traffic\_only\_enabled) | Boolean flag which forces HTTPS if enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | An identity block. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_immutability_policy"></a> [immutability\_policy](#input\_immutability\_policy) | An immutability\_policy block. | <pre>object({<br>    allow_protected_append_writes = bool<br>    state                         = string<br>    period_since_creation_in_days = number<br>  })</pre> | `null` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| <a name="input_is_hns_enabled"></a> [is\_hns\_enabled](#input\_is\_hns\_enabled) | Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_large_file_share_enabled"></a> [large\_file\_share\_enabled](#input\_large\_file\_share\_enabled) | Are Large File Shares Enabled? Defaults to false. | `bool` | `false` | no |
| <a name="input_local_user_enabled"></a> [local\_user\_enabled](#input\_local\_user\_enabled) | Is Local User Enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_min_tls_version"></a> [min\_tls\_version](#input\_min\_tls\_version) | The minimum supported TLS version for the storage account. Possible values are TLS1\_0, TLS1\_1, and TLS1\_2. Defaults to TLS1\_2 for new storage accounts. | `string` | `"TLS1_2"` | no |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group. | `string` | n/a | yes |
| <a name="input_network_rules"></a> [network\_rules](#input\_network\_rules) | A network\_rules block. | <pre>object({<br>    default_action             = string<br>    bypass                     = optional(list(string))<br>    ip_rules                   = optional(list(string))<br>    virtual_network_subnet_ids = optional(list(string))<br>    private_link_access        = optional(list(object({<br>      endpoint_resource_id = string<br>      endpoint_tenant_id   = optional(string)<br>    })))<br>  })</pre> | `null` | no |
| <a name="input_nfsv3_enabled"></a> [nfsv3\_enabled](#input\_nfsv3\_enabled) | Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false. | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the public network access is enabled? Defaults to true. | `bool` | `true` | no |
| <a name="input_queue_encryption_key_type"></a> [queue\_encryption\_key\_type](#input\_queue\_encryption\_key\_type) | The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service. | `string` | `"Service"` | no |
| <a name="input_queue_properties"></a> [queue\_properties](#input\_queue\_properties) | A queue\_properties block. | <pre>object({<br>    cors_rule = optional(list(object({<br>      allowed_headers    = list(string)<br>      allowed_methods    = list(string)<br>      allowed_origins    = list(string)<br>      exposed_headers    = list(string)<br>      max_age_in_seconds = number<br>    })))<br>    logging = optional(object({<br>      delete               = bool<br>      read                 = bool<br>      version              = string<br>      write                = bool<br>      retention_policy_days = optional(number)<br>    }))<br>    minute_metrics = optional(object({<br>      enabled              = bool<br>      version              = string<br>      include_apis         = optional(bool)<br>      retention_policy_days = optional(number)<br>    }))<br>    hour_metrics = optional(object({<br>      enabled              = bool<br>      version              = string<br>      include_apis         = optional(bool)<br>      retention_policy_days = optional(number)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the storage account. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_routing"></a> [routing](#input\_routing) | A routing block. | <pre>object({<br>    publish_internet_endpoints  = optional(bool, false)<br>    publish_microsoft_endpoints = optional(bool, false)<br>    choice                      = optional(string, "MicrosoftRouting")<br>  })</pre> | `null` | no |
| <a name="input_sas_policy"></a> [sas\_policy](#input\_sas\_policy) | A sas\_policy block. | <pre>object({<br>    expiration_period = string<br>    expiration_action = optional(string, "Log")<br>  })</pre> | `null` | no |
| <a name="input_sftp_enabled"></a> [sftp\_enabled](#input\_sftp\_enabled) | Boolean, enable SFTP for the storage account. Defaults to false. | `bool` | `false` | no |
| <a name="input_share_properties"></a> [share\_properties](#input\_share\_properties) | A share\_properties block. | <pre>object({<br>    cors_rule = optional(list(object({<br>      allowed_headers    = list(string)<br>      allowed_methods    = list(string)<br>      allowed_origins    = list(string)<br>      exposed_headers    = list(string)<br>      max_age_in_seconds = number<br>    })))<br>    retention_policy = optional(object({<br>      days = optional(number, 7)<br>    }))<br>    smb = optional(object({<br>      versions                      = optional(list(string))<br>      authentication_types          = optional(list(string))<br>      kerberos_ticket_encryption_type = optional(list(string))<br>      channel_encryption_type       = optional(list(string))<br>      multichannel_enabled          = optional(bool, false)<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. Defaults to true. | `bool` | `true` | no |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | A static\_website block. | <pre>object({<br>    index_document = optional(string)<br>    error_404_document = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription id where the storage account is created | `string` | n/a | yes |
| <a name="input_table_encryption_key_type"></a> [table\_encryption\_key\_type](#input\_table\_encryption\_key\_type) | The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service. | `string` | `"Service"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | The timeouts block allows you to specify timeout durations for different operations. | <pre>object({<br>    create = optional(string, "60m")<br>    update = optional(string, "60m")<br>    read   = optional(string, "5m")<br>    delete = optional(string, "60m")<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity"></a> [identity](#output\_identity) | An identity block. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_primary_blob_connection_string"></a> [primary\_blob\_connection\_string](#output\_primary\_blob\_connection\_string) | The connection string associated with the primary blob location. |
| <a name="output_primary_blob_endpoint"></a> [primary\_blob\_endpoint](#output\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_primary_blob_host"></a> [primary\_blob\_host](#output\_primary\_blob\_host) | The hostname with port if applicable for blob storage in the primary location. |
| <a name="output_primary_blob_internet_endpoint"></a> [primary\_blob\_internet\_endpoint](#output\_primary\_blob\_internet\_endpoint) | The internet routing endpoint URL for blob storage in the primary location. |
| <a name="output_primary_blob_internet_host"></a> [primary\_blob\_internet\_host](#output\_primary\_blob\_internet\_host) | The internet routing hostname with port if applicable for blob storage in the primary location. |
| <a name="output_primary_blob_microsoft_endpoint"></a> [primary\_blob\_microsoft\_endpoint](#output\_primary\_blob\_microsoft\_endpoint) | The microsoft routing endpoint URL for blob storage in the primary location. |
| <a name="output_primary_blob_microsoft_host"></a> [primary\_blob\_microsoft\_host](#output\_primary\_blob\_microsoft\_host) | The microsoft routing hostname with port if applicable for blob storage in the primary location. |
| <a name="output_primary_connection_string"></a> [primary\_connection\_string](#output\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_primary_dfs_endpoint"></a> [primary\_dfs\_endpoint](#output\_primary\_dfs\_endpoint) | The endpoint URL for DFS storage in the primary location. |
| <a name="output_primary_dfs_host"></a> [primary\_dfs\_host](#output\_primary\_dfs\_host) | The hostname with port if applicable for DFS storage in the primary location. |
| <a name="output_primary_dfs_internet_endpoint"></a> [primary\_dfs\_internet\_endpoint](#output\_primary\_dfs\_internet\_endpoint) | The internet routing endpoint URL for DFS storage in the primary location. |
| <a name="output_primary_dfs_internet_host"></a> [primary\_dfs\_internet\_host](#output\_primary\_dfs\_internet\_host) | The internet routing hostname with port if applicable for DFS storage in the primary location. |
| <a name="output_primary_dfs_microsoft_endpoint"></a> [primary\_dfs\_microsoft\_endpoint](#output\_primary\_dfs\_microsoft\_endpoint) | The microsoft routing endpoint URL for DFS storage in the primary location. |
| <a name="output_primary_dfs_microsoft_host"></a> [primary\_dfs\_microsoft\_host](#output\_primary\_dfs\_microsoft\_host) | The microsoft routing hostname with port if applicable for DFS storage in the primary location. |
| <a name="output_primary_file_endpoint"></a> [primary\_file\_endpoint](#output\_primary\_file\_endpoint) | The endpoint URL for file storage in the primary location. |
| <a name="output_primary_file_host"></a> [primary\_file\_host](#output\_primary\_file\_host) | The hostname with port if applicable for file storage in the primary location. |
| <a name="output_primary_file_internet_endpoint"></a> [primary\_file\_internet\_endpoint](#output\_primary\_file\_internet\_endpoint) | The internet routing endpoint URL for file storage in the primary location. |
| <a name="output_primary_file_internet_host"></a> [primary\_file\_internet\_host](#output\_primary\_file\_internet\_host) | The internet routing hostname with port if applicable for file storage in the primary location. |
| <a name="output_primary_file_microsoft_endpoint"></a> [primary\_file\_microsoft\_endpoint](#output\_primary\_file\_microsoft\_endpoint) | The microsoft routing endpoint URL for file storage in the primary location. |
| <a name="output_primary_file_microsoft_host"></a> [primary\_file\_microsoft\_host](#output\_primary\_file\_microsoft\_host) | The microsoft routing hostname with port if applicable for file storage in the primary location. |
| <a name="output_primary_location"></a> [primary\_location](#output\_primary\_location) | The primary location of the storage account. |
| <a name="output_primary_queue_endpoint"></a> [primary\_queue\_endpoint](#output\_primary\_queue\_endpoint) | The endpoint URL for queue storage in the primary location. |
| <a name="output_primary_queue_host"></a> [primary\_queue\_host](#output\_primary\_queue\_host) | The hostname with port if applicable for queue storage in the primary location. |
| <a name="output_primary_queue_microsoft_endpoint"></a> [primary\_queue\_microsoft\_endpoint](#output\_primary\_queue\_microsoft\_endpoint) | The microsoft routing endpoint URL for queue storage in the primary location. |
| <a name="output_primary_queue_microsoft_host"></a> [primary\_queue\_microsoft\_host](#output\_primary\_queue\_microsoft\_host) | The microsoft routing hostname with port if applicable for queue storage in the primary location. |
| <a name="output_primary_table_endpoint"></a> [primary\_table\_endpoint](#output\_primary\_table\_endpoint) | The endpoint URL for table storage in the primary location. |
| <a name="output_primary_table_host"></a> [primary\_table\_host](#output\_primary\_table\_host) | The hostname with port if applicable for table storage in the primary location. |
| <a name="output_primary_table_microsoft_endpoint"></a> [primary\_table\_microsoft\_endpoint](#output\_primary\_table\_microsoft\_endpoint) | The microsoft routing endpoint URL for table storage in the primary location. |
| <a name="output_primary_table_microsoft_host"></a> [primary\_table\_microsoft\_host](#output\_primary\_table\_microsoft\_host) | The microsoft routing hostname with port if applicable for table storage in the primary location. |
| <a name="output_primary_web_endpoint"></a> [primary\_web\_endpoint](#output\_primary\_web\_endpoint) | The endpoint URL for web storage in the primary location. |
| <a name="output_primary_web_host"></a> [primary\_web\_host](#output\_primary\_web\_host) | The hostname with port if applicable for web storage in the primary location. |
| <a name="output_primary_web_internet_endpoint"></a> [primary\_web\_internet\_endpoint](#output\_primary\_web\_internet\_endpoint) | The internet routing endpoint URL for web storage in the primary location. |
| <a name="output_primary_web_internet_host"></a> [primary\_web\_internet\_host](#output\_primary\_web\_internet\_host) | The internet routing hostname with port if applicable for web storage in the primary location. |
| <a name="output_primary_web_microsoft_endpoint"></a> [primary\_web\_microsoft\_endpoint](#output\_primary\_web\_microsoft\_endpoint) | The microsoft routing endpoint URL for web storage in the primary location. |
| <a name="output_primary_web_microsoft_host"></a> [primary\_web\_microsoft\_host](#output\_primary\_web\_microsoft\_host) | The microsoft routing hostname with port if applicable for web storage in the primary location. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The secondary access key for the storage account. |
| <a name="output_secondary_blob_connection_string"></a> [secondary\_blob\_connection\_string](#output\_secondary\_blob\_connection\_string) | The connection string associated with the secondary blob location. |
| <a name="output_secondary_blob_endpoint"></a> [secondary\_blob\_endpoint](#output\_secondary\_blob\_endpoint) | The endpoint URL for blob storage in the secondary location. |
| <a name="output_secondary_blob_host"></a> [secondary\_blob\_host](#output\_secondary\_blob\_host) | The hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_secondary_blob_internet_endpoint"></a> [secondary\_blob\_internet\_endpoint](#output\_secondary\_blob\_internet\_endpoint) | The internet routing endpoint URL for blob storage in the secondary location. |
| <a name="output_secondary_blob_internet_host"></a> [secondary\_blob\_internet\_host](#output\_secondary\_blob\_internet\_host) | The internet routing hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_secondary_blob_microsoft_endpoint"></a> [secondary\_blob\_microsoft\_endpoint](#output\_secondary\_blob\_microsoft\_endpoint) | The microsoft routing endpoint URL for blob storage in the secondary location. |
| <a name="output_secondary_blob_microsoft_host"></a> [secondary\_blob\_microsoft\_host](#output\_secondary\_blob\_microsoft\_host) | The microsoft routing hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_secondary_connection_string"></a> [secondary\_connection\_string](#output\_secondary\_connection\_string) | The connection string associated with the secondary location. |
| <a name="output_secondary_dfs_endpoint"></a> [secondary\_dfs\_endpoint](#output\_secondary\_dfs\_endpoint) | The endpoint URL for DFS storage in the secondary location. |
| <a name="output_secondary_dfs_host"></a> [secondary\_dfs\_host](#output\_secondary\_dfs\_host) | The hostname with port if applicable for DFS storage in the secondary location. |
| <a name="output_secondary_dfs_internet_endpoint"></a> [secondary\_dfs\_internet\_endpoint](#output\_secondary\_dfs\_internet\_endpoint) | The internet routing endpoint URL for DFS storage in the secondary location. |
| <a name="output_secondary_dfs_internet_host"></a> [secondary\_dfs\_internet\_host](#output\_secondary\_dfs\_internet\_host) | The internet routing hostname with port if applicable for DFS storage in the secondary location. |
| <a name="output_secondary_dfs_microsoft_endpoint"></a> [secondary\_dfs\_microsoft\_endpoint](#output\_secondary\_dfs\_microsoft\_endpoint) | The microsoft routing endpoint URL for DFS storage in the secondary location. |
| <a name="output_secondary_dfs_microsoft_host"></a> [secondary\_dfs\_microsoft\_host](#output\_secondary\_dfs\_microsoft\_host) | The microsoft routing hostname with port if applicable for DFS storage in the secondary location. |
| <a name="output_secondary_file_endpoint"></a> [secondary\_file\_endpoint](#output\_secondary\_file\_endpoint) | The endpoint URL for file storage in the secondary location. |
| <a name="output_secondary_file_host"></a> [secondary\_file\_host](#output\_secondary\_file\_host) | The hostname with port if applicable for file storage in the secondary location. |
| <a name="output_secondary_file_internet_endpoint"></a> [secondary\_file\_internet\_endpoint](#output\_secondary\_file\_internet\_endpoint) | The internet routing endpoint URL for file storage in the secondary location. |
| <a name="output_secondary_file_internet_host"></a> [secondary\_file\_internet\_host](#output\_secondary\_file\_internet\_host) | The internet routing hostname with port if applicable for file storage in the secondary location. |
| <a name="output_secondary_file_microsoft_endpoint"></a> [secondary\_file\_microsoft\_endpoint](#output\_secondary\_file\_microsoft\_endpoint) | The microsoft routing endpoint URL for file storage in the secondary location. |
| <a name="output_secondary_file_microsoft_host"></a> [secondary\_file\_microsoft\_host](#output\_secondary\_file\_microsoft\_host) | The microsoft routing hostname with port if applicable for file storage in the secondary location. |
| <a name="output_secondary_location"></a> [secondary\_location](#output\_secondary\_location) | The secondary location of the storage account. |
| <a name="output_secondary_queue_endpoint"></a> [secondary\_queue\_endpoint](#output\_secondary\_queue\_endpoint) | The endpoint URL for queue storage in the secondary location. |
| <a name="output_secondary_queue_host"></a> [secondary\_queue\_host](#output\_secondary\_queue\_host) | The hostname with port if applicable for queue storage in the secondary location. |
| <a name="output_secondary_queue_microsoft_endpoint"></a> [secondary\_queue\_microsoft\_endpoint](#output\_secondary\_queue\_microsoft\_endpoint) | The microsoft routing endpoint URL for queue storage in the secondary location. |
| <a name="output_secondary_queue_microsoft_host"></a> [secondary\_queue\_microsoft\_host](#output\_secondary\_queue\_microsoft\_host) | The microsoft routing hostname with port if applicable for queue storage in the secondary location. |
| <a name="output_secondary_table_endpoint"></a> [secondary\_table\_endpoint](#output\_secondary\_table\_endpoint) | The endpoint URL for table storage in the secondary location. |
| <a name="output_secondary_table_host"></a> [secondary\_table\_host](#output\_secondary\_table\_host) | The hostname with port if applicable for table storage in the secondary location. |
| <a name="output_secondary_table_microsoft_endpoint"></a> [secondary\_table\_microsoft\_endpoint](#output\_secondary\_table\_microsoft\_endpoint) | The microsoft routing endpoint URL for table storage in the secondary location. |
| <a name="output_secondary_table_microsoft_host"></a> [secondary\_table\_microsoft\_host](#output\_secondary\_table\_microsoft\_host) | The microsoft routing hostname with port if applicable for table storage in the secondary location. |
| <a name="output_secondary_web_endpoint"></a> [secondary\_web\_endpoint](#output\_secondary\_web\_endpoint) | The endpoint URL for web storage in the secondary location. |
| <a name="output_secondary_web_host"></a> [secondary\_web\_host](#output\_secondary\_web\_host) | The hostname with port if applicable for web storage in the secondary location. |
| <a name="output_secondary_web_internet_endpoint"></a> [secondary\_web\_internet\_endpoint](#output\_secondary\_web\_internet\_endpoint) | The internet routing endpoint URL for web storage in the secondary location. |
| <a name="output_secondary_web_internet_host"></a> [secondary\_web\_internet\_host](#output\_secondary\_web\_internet\_host) | The internet routing hostname with port if applicable for web storage in the secondary location. |
| <a name="output_secondary_web_microsoft_endpoint"></a> [secondary\_web\_microsoft\_endpoint](#output\_secondary\_web\_microsoft\_endpoint) | The microsoft routing endpoint URL for web storage in the secondary location. |
| <a name="output_secondary_web_microsoft_host"></a> [secondary\_web\_microsoft\_host](#output\_secondary\_web\_microsoft\_host) | The microsoft routing hostname with port if applicable for web storage in the secondary location. |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the Storage Account. |
