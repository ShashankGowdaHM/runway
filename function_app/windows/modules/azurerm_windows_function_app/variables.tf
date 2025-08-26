variable "location" {
  description = "The Azure Region where the Windows Function App should exist. Changing this forces a new Windows Function App to be created."
  type        = string
}

variable "name" {
  description = "The name which should be used for this Windows Function App. Changing this forces a new Windows Function App to be created. Limit the function name to 32 characters to avoid naming collisions."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Windows Function App should exist. Changing this forces a new Windows Function App to be created."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the App Service Plan within which to create this Function App."
  type        = string
}

variable "site_config" {
  description = "A site_config block."
  type = object({
    always_on                              = optional(bool, false)
    api_definition_url                     = optional(string)
    api_management_api_id                  = optional(string)
    app_command_line                       = optional(string)
    app_scale_limit                        = optional(number)
    application_insights_connection_string = optional(string)
    application_insights_key               = optional(string)
    application_stack = optional(object({
      dotnet_version              = optional(string)
      use_dotnet_isolated_runtime = optional(bool, false)
      java_version                = optional(string)
      node_version                = optional(string)
      powershell_core_version     = optional(string)
      use_custom_runtime          = optional(bool, false)
    }))
    app_service_logs = optional(object({
      disk_quota_mb         = optional(number, 35)
      retention_period_days = optional(number, 0)
    }))
    cors = optional(object({
      allowed_origins     = optional(list(string))
      support_credentials = optional(bool, false)
    }))
    default_documents                 = optional(list(string))
    elastic_instance_minimum          = optional(number)
    ftps_state                        = optional(string, "Disabled")
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(number)
    http2_enabled                     = optional(bool, false)
    ip_restriction = optional(list(object({
      action = optional(string, "Allow")
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(string)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number, 65000)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      description               = optional(string)
    })))
    ip_restriction_default_action    = optional(string, "Allow")
    load_balancing_mode              = optional(string, "LeastRequests")
    managed_pipeline_mode            = optional(string, "Integrated")
    minimum_tls_version              = optional(string, "1.2")
    pre_warmed_instance_count        = optional(number)
    remote_debugging_enabled         = optional(bool, false)
    remote_debugging_version         = optional(string)
    runtime_scale_monitoring_enabled = optional(bool, false)
    scm_ip_restriction = optional(list(object({
      action = optional(string, "Allow")
      headers = optional(object({
        x_azure_fdid      = optional(list(string))
        x_fd_health_probe = optional(string)
        x_forwarded_for   = optional(list(string))
        x_forwarded_host  = optional(list(string))
      }))
      ip_address                = optional(string)
      name                      = optional(string)
      priority                  = optional(number, 65000)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      description               = optional(string)
    })))
    scm_ip_restriction_default_action = optional(string, "Allow")
    scm_minimum_tls_version           = optional(string, "1.2")
    scm_use_main_ip_restriction       = optional(bool, false)
    use_32_bit_worker                 = optional(bool, true)
    vnet_route_all_enabled            = optional(bool, false)
    websockets_enabled                = optional(bool, false)
    worker_count                      = optional(number)
  })
}

variable "app_settings" {
  description = "A map of key-value pairs for App Settings and custom values."
  type        = map(string)
  default     = {}
}

variable "auth_settings" {
  description = "A auth_settings block."
  type = object({
    enabled = bool
    active_directory = optional(object({
      client_id                  = string
      allowed_audiences          = optional(list(string))
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
    }))
    additional_login_parameters    = optional(map(string))
    allowed_external_redirect_urls = optional(list(string))
    default_provider               = optional(string)
    facebook = optional(object({
      app_id                  = string
      app_secret              = optional(string)
      app_secret_setting_name = optional(string)
      oauth_scopes            = optional(list(string))
    }))
    github = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    google = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    issuer = optional(string)
    microsoft = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    runtime_version               = optional(string)
    token_refresh_extension_hours = optional(number, 72)
    token_store_enabled           = optional(bool, false)
    twitter = optional(object({
      consumer_key                 = string
      consumer_secret              = optional(string)
      consumer_secret_setting_name = optional(string)
    }))
    unauthenticated_client_action = optional(string)
  })
  default = null
}

variable "auth_settings_v2" {
  description = "An auth_settings_v2 block."
  type = object({
    auth_enabled                            = optional(bool, false)
    runtime_version                         = optional(string, "~1")
    config_file_path                        = optional(string)
    require_authentication                  = optional(bool)
    unauthenticated_action                  = optional(string, "RedirectToLoginPage")
    default_provider                        = optional(string)
    excluded_paths                          = optional(list(string))
    require_https                           = optional(bool, true)
    http_route_api_prefix                   = optional(string, "/.auth")
    forward_proxy_convention                = optional(string, "NoProxy")
    forward_proxy_custom_host_header_name   = optional(string)
    forward_proxy_custom_scheme_header_name = optional(string)
    apple_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    active_directory_v2 = optional(object({
      client_id                            = string
      tenant_auth_endpoint                 = string
      client_secret_setting_name           = optional(string)
      client_secret_certificate_thumbprint = optional(string)
      jwt_allowed_groups                   = optional(list(string))
      jwt_allowed_client_applications      = optional(list(string))
      www_authentication_disabled          = optional(bool, false)
      allowed_groups                       = optional(list(string))
      allowed_identities                   = optional(list(string))
      allowed_applications                 = optional(list(string))
      login_parameters                     = optional(map(string))
      allowed_audiences                    = optional(list(string))
    }))
    azure_static_web_app_v2 = optional(object({
      client_id = string
    }))
    custom_oidc_v2 = optional(list(object({
      name                          = string
      client_id                     = string
      openid_configuration_endpoint = string
      name_claim_type               = optional(string)
      scopes                        = optional(list(string))
      client_credential_method      = optional(string)
      client_secret_setting_name    = optional(string)
      authorisation_endpoint        = optional(string)
      token_endpoint                = optional(string)
      issuer_endpoint               = optional(string)
      certification_uri             = optional(string)
    })))
    facebook_v2 = optional(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(list(string))
    }))
    github_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    google_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    microsoft_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    twitter_v2 = optional(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    }))
    login = object({
      logout_endpoint                   = optional(string)
      token_store_enabled               = optional(bool, false)
      token_refresh_extension_time      = optional(number, 72)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      preserve_url_fragments_for_logins = optional(bool, false)
      allowed_external_redirect_urls    = optional(list(string))
      cookie_expiration_convention      = optional(string, "FixedTime")
      cookie_expiration_time            = optional(string, "08:00:00")
      validate_nonce                    = optional(bool, true)
      nonce_expiration_time             = optional(string, "00:05:00")
    })
  })
  default = null
}

variable "backup" {
  description = "A backup block."
  type = object({
    name = string
    schedule = object({
      frequency_interval       = number
      frequency_unit           = string
      keep_at_least_one_backup = optional(bool, false)
      retention_period_days    = optional(number, 30)
      start_time               = optional(string)
    })
    storage_account_url = string
    enabled             = optional(bool, true)
  })
  default = null
}

variable "builtin_logging_enabled" {
  description = "Should built in logging be enabled. Configures AzureWebJobsDashboard app setting based on the configured storage setting. Defaults to true."
  type        = bool
  default     = true
}

variable "client_certificate_enabled" {
  description = "Should the function app use Client Certificates."
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "The mode of the Function App's client certificates requirement for incoming requests. Possible values are Required, Optional, and OptionalInteractiveUser. Defaults to Optional."
  type        = string
  default     = "Optional"
}

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude when using client certificates, separated by ;"
  type        = string
  default     = null
}

variable "connection_string" {
  description = "One or more connection_string blocks."
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = []
}

variable "content_share_force_disabled" {
  description = "Should Content Share Settings be disabled. Defaults to false."
  type        = bool
  default     = false
}

variable "daily_memory_time_quota" {
  description = "The amount of memory in gigabyte-seconds that your application is allowed to consume per day. Setting this value only affects function apps under the consumption plan. Defaults to 0."
  type        = number
  default     = 0
}

variable "enabled" {
  description = "Is the Function App enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "Should the default FTP Basic Authentication publishing profile be enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "functions_extension_version" {
  description = "The runtime version associated with the Function App. Defaults to ~4."
  type        = string
  default     = "~4"
}

variable "https_only" {
  description = "Can the Function App only be accessed via HTTPS?. Defaults to false."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Should public network access be enabled for the Function App. Defaults to true."
  type        = bool
  default     = true
}

variable "identity" {
  description = "A identity block."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "key_vault_reference_identity_id" {
  description = "The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the identity block."
  type        = string
  default     = null
}

variable "storage_account" {
  description = "One or more storage_account blocks."
  type = list(object({
    access_key   = string
    account_name = string
    name         = string
    share_name   = string
    type         = string
    mount_path   = optional(string)
  }))
  default = []
}

variable "sticky_settings" {
  description = "A sticky_settings block."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
}

variable "storage_account_access_key" {
  description = "The access key which will be used to access the backend storage account for the Function App. Conflicts with storage_uses_managed_identity."
  type        = string
  default     = null
}

variable "storage_account_name" {
  description = "The backend storage account name which will be used by this Function App."
  type        = string
  default     = null
}

variable "storage_uses_managed_identity" {
  description = "Should the Function App use Managed Identity to access the storage account. Conflicts with storage_account_access_key."
  type        = bool
  default     = false
}

variable "storage_key_vault_secret_id" {
  description = "The Key Vault Secret ID, optionally including version, that contains the Connection String to connect to the storage account for this Function App."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Windows Function App."
  type        = map(string)
  default     = {}
}

variable "virtual_network_subnet_id" {
  description = "The subnet id which will be used by this Function App for regional virtual network integration."
  type        = string
  default     = null
}

variable "vnet_image_pull_enabled" {
  description = "Specifies whether traffic for the image pull should be routed over virtual network. Defaults to false."
  type        = bool
  default     = false
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "Should the default WebDeploy Basic Authentication publishing credentials enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "zip_deploy_file" {
  description = "The local path and filename of the Zip packaged application to deploy to this Windows Function App."
  type        = string
  default     = null
}

variable "create_timeout" {
  description = "Timeout for creating the Service Plan. Defaults to 1 hour."
  type        = string
  default     = "30m"
}

variable "read_timeout" {
  description = "Timeout for reading the Service Plan. Defaults to 5 minutes."
  type        = string
  default     = "5m"
}

variable "update_timeout" {
  description = "Timeout for updating the Service Plan. Defaults to 1 hour."
  type        = string
  default     = "30m"
}

variable "delete_timeout" {
  description = "Timeout for deleting the Service Plan. Defaults to 1 hour."
  type        = string
  default     = "30m"
}

variable "subscription_id" {
  description = "The Subscription ID where the Function App should exist."
  type        = string
}