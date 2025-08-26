variable "name" {
  description = "Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "account_kind" {
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
  type        = string
  default     = "StorageV2"
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  type        = string
}

variable "cross_tenant_replication_enabled" {
  description = "Should cross Tenant replication be enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  type        = string
  default     = "Hot"
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}

variable "https_traffic_only_enabled" {
  description = "Boolean flag which forces HTTPS if enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  type        = string
  default     = "TLS1_2"
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. Defaults to true."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether the public network access is enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false."
  type        = bool
  default     = false
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = false
}

variable "custom_domain" {
  description = "A custom_domain block."
  type = object({
    name          = string
    use_subdomain = optional(bool)
  })
  default = null
}

variable "customer_managed_key" {
  description = "A customer_managed_key block."
  type = object({
    key_vault_key_id          = optional(string)
    managed_hsm_key_id        = optional(string)
    user_assigned_identity_id = string
  })
  default = null
}

variable "identity" {
  description = "An identity block."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "blob_properties" {
  description = "A blob_properties block."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    delete_retention_policy = optional(object({
      days                     = optional(number, 7)
      permanent_delete_enabled = optional(bool, false)
    }))
    restore_policy = optional(object({
      days = number
    }))
    versioning_enabled            = optional(bool, false)
    change_feed_enabled           = optional(bool, false)
    change_feed_retention_in_days = optional(number)
    default_service_version       = optional(string)
    last_access_time_enabled      = optional(bool, false)
    container_delete_retention_policy = optional(object({
      days = optional(number, 7)
    }))
  })
  default = null
}

variable "queue_properties" {
  description = "A queue_properties block."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    logging = optional(object({
      delete                = bool
      read                  = bool
      version               = string
      write                 = bool
      retention_policy_days = optional(number)
    }))
    minute_metrics = optional(object({
      enabled               = bool
      version               = string
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
    }))
    hour_metrics = optional(object({
      enabled               = bool
      version               = string
      include_apis          = optional(bool)
      retention_policy_days = optional(number)
    }))
  })
  default = null
}

variable "static_website" {
  description = "A static_website block."
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  default = null
}

variable "share_properties" {
  description = "A share_properties block."
  type = object({
    cors_rule = optional(list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    })))
    retention_policy = optional(object({
      days = optional(number, 7)
    }))
    smb = optional(object({
      versions                        = optional(list(string))
      authentication_types            = optional(list(string))
      kerberos_ticket_encryption_type = optional(list(string))
      channel_encryption_type         = optional(list(string))
      multichannel_enabled            = optional(bool, false)
    }))
  })
  default = null
}

variable "network_rules" {
  description = "A network_rules block."
  type = object({
    default_action             = string
    bypass                     = optional(list(string))
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
    private_link_access = optional(list(object({
      endpoint_resource_id = string
      endpoint_tenant_id   = optional(string)
    })))
  })
  default = null
}

variable "large_file_share_enabled" {
  description = "Are Large File Shares Enabled? Defaults to false."
  type        = bool
  default     = false
}

variable "local_user_enabled" {
  description = "Is Local User Enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "azure_files_authentication" {
  description = "A azure_files_authentication block."
  type = object({
    directory_type = string
    active_directory = optional(object({
      domain_name         = string
      domain_guid         = string
      domain_sid          = optional(string)
      storage_sid         = optional(string)
      forest_name         = optional(string)
      netbios_domain_name = optional(string)
    }))
    default_share_level_permission = optional(string)
  })
  default = null
}

variable "routing" {
  description = "A routing block."
  type = object({
    publish_internet_endpoints  = optional(bool, false)
    publish_microsoft_endpoints = optional(bool, false)
    choice                      = optional(string, "MicrosoftRouting")
  })
  default = null
}

variable "queue_encryption_key_type" {
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  type        = string
  default     = "Service"
}

variable "table_encryption_key_type" {
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  type        = string
  default     = "Service"
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
  type        = bool
  default     = false
}

variable "immutability_policy" {
  description = "An immutability_policy block."
  type = object({
    allow_protected_append_writes = bool
    state                         = string
    period_since_creation_in_days = number
  })
  default = null
}

variable "sas_policy" {
  description = "A sas_policy block."
  type = object({
    expiration_period = string
    expiration_action = optional(string, "Log")
  })
  default = null
}

variable "allowed_copy_scope" {
  description = "Restrict copy to and from Storage Accounts within an AAD tenant or with Private Links to the same VNet. Possible values are AAD and PrivateLink."
  type        = string
  default     = null
}

variable "sftp_enabled" {
  description = "Boolean, enable SFTP for the storage account. Defaults to false."
  type        = bool
  default     = false
}

variable "dns_endpoint_type" {
  description = "Specifies which DNS endpoint type to use. Possible values are Standard and AzureDnsZone. Defaults to Standard. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "Timeout for creating the Public IP"
  type        = string
  default     = "60m"
}

variable "update_timeout" {
  description = "Timeout for updating the Public IP"
  type        = string
  default     = "60m"
}

variable "read_timeout" {
  description = "Timeout for reading the Public IP"
  type        = string
  default     = "5m"
}

variable "delete_timeout" {
  description = "Timeout for deleting the Public IP"
  type        = string
  default     = "60m"
}

variable "subscription_id" {
  description = "Subscription id where the storage account is created"
  type        = string
}