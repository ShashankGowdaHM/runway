# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_linux_function_app" "linux_function_app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  storage_account_name          = var.storage_account_name != null ? var.storage_account_name : null
  storage_account_access_key    = var.storage_account_access_key != null ? var.storage_account_access_key : null
  storage_uses_managed_identity = var.storage_uses_managed_identity != null ? var.storage_uses_managed_identity : null
  storage_key_vault_secret_id   = var.storage_key_vault_secret_id != null ? var.storage_key_vault_secret_id : null

  app_settings = var.app_settings

  site_config {
    always_on                              = lookup(var.site_config, "always_on", false)
    api_definition_url                     = lookup(var.site_config, "api_definition_url", null)
    api_management_api_id                  = lookup(var.site_config, "api_management_api_id", null)
    app_command_line                       = lookup(var.site_config, "app_command_line", null)
    app_scale_limit                        = lookup(var.site_config, "app_scale_limit", null)
    application_insights_connection_string = lookup(var.site_config, "application_insights_connection_string", null)
    application_insights_key               = lookup(var.site_config, "application_insights_key", null)
    application_stack {
      dynamic "docker" {
        for_each = lookup(var.site_config.application_stack, "docker", [])
        content {
          registry_url      = docker.value.registry_url
          image_name        = docker.value.image_name
          image_tag         = docker.value.image_tag
          registry_username = lookup(docker.value, "registry_username", null)
          registry_password = lookup(docker.value, "registry_password", null)
        }
      }
      dotnet_version              = lookup(var.site_config.application_stack, "dotnet_version", null)
      use_dotnet_isolated_runtime = lookup(var.site_config.application_stack, "use_dotnet_isolated_runtime", false)
      java_version                = lookup(var.site_config.application_stack, "java_version", null)
      node_version                = lookup(var.site_config.application_stack, "node_version", null)
      python_version              = lookup(var.site_config.application_stack, "python_version", null)
      powershell_core_version     = lookup(var.site_config.application_stack, "powershell_core_version", null)
      use_custom_runtime          = lookup(var.site_config.application_stack, "use_custom_runtime", false)
    }
    app_service_logs {
      disk_quota_mb         = lookup(var.site_config.app_service_logs, "disk_quota_mb", 35)
      retention_period_days = lookup(var.site_config.app_service_logs, "retention_period_days", 0)
    }
    cors {
      allowed_origins     = lookup(var.site_config.cors, "allowed_origins", [])
      support_credentials = lookup(var.site_config.cors, "support_credentials", false)
    }
    default_documents                 = lookup(var.site_config, "default_documents", [])
    elastic_instance_minimum          = lookup(var.site_config, "elastic_instance_minimum", null)
    ftps_state                        = lookup(var.site_config, "ftps_state", "Disabled")
    health_check_path                 = lookup(var.site_config, "health_check_path", null)
    health_check_eviction_time_in_min = lookup(var.site_config, "health_check_eviction_time_in_min", null)
    http2_enabled                     = lookup(var.site_config, "http2_enabled", false)

    dynamic "ip_restriction" {
      for_each = lookup(var.site_config, "ip_restriction", [])
      content {
        action = lookup(ip_restriction.value, "action", "Allow")
        headers {
          x_azure_fdid      = lookup(ip_restriction.value.headers, "x_azure_fdid", [])
          x_fd_health_probe = lookup(ip_restriction.value.headers, "x_fd_health_probe", null)
          x_forwarded_for   = lookup(ip_restriction.value.headers, "x_forwarded_for", [])
          x_forwarded_host  = lookup(ip_restriction.value.headers, "x_forwarded_host", [])
        }
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        priority                  = lookup(ip_restriction.value, "priority", 65000)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
        description               = lookup(ip_restriction.value, "description", null)
      }
    }

    ip_restriction_default_action    = lookup(var.site_config, "ip_restriction_default_action", "Allow")
    load_balancing_mode              = lookup(var.site_config, "load_balancing_mode", "LeastRequests")
    managed_pipeline_mode            = lookup(var.site_config, "managed_pipeline_mode", "Integrated")
    minimum_tls_version              = lookup(var.site_config, "minimum_tls_version", "1.2")
    pre_warmed_instance_count        = lookup(var.site_config, "pre_warmed_instance_count", null)
    remote_debugging_enabled         = lookup(var.site_config, "remote_debugging_enabled", false)
    remote_debugging_version         = lookup(var.site_config, "remote_debugging_version", null)
    runtime_scale_monitoring_enabled = lookup(var.site_config, "runtime_scale_monitoring_enabled", false)

    dynamic "scm_ip_restriction" {
      for_each = lookup(var.site_config, "scm_ip_restriction", [])
      content {
        action = lookup(scm_ip_restriction.value, "action", "Allow")
        headers {
          x_azure_fdid      = lookup(scm_ip_restriction.value.headers, "x_azure_fdid", [])
          x_fd_health_probe = lookup(scm_ip_restriction.value.headers, "x_fd_health_probe", null)
          x_forwarded_for   = lookup(scm_ip_restriction.value.headers, "x_forwarded_for", [])
          x_forwarded_host  = lookup(scm_ip_restriction.value.headers, "x_forwarded_host", [])
        }
        ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
        name                      = lookup(scm_ip_restriction.value, "name", null)
        priority                  = lookup(scm_ip_restriction.value, "priority", 65000)
        service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
        description               = lookup(scm_ip_restriction.value, "description", null)
      }
    }

    scm_ip_restriction_default_action = lookup(var.site_config, "scm_ip_restriction_default_action", "Allow")
    scm_minimum_tls_version           = lookup(var.site_config, "scm_minimum_tls_version", "1.2")
    scm_use_main_ip_restriction       = lookup(var.site_config, "scm_use_main_ip_restriction", false)
    use_32_bit_worker                 = lookup(var.site_config, "use_32_bit_worker", false)
    vnet_route_all_enabled            = lookup(var.site_config, "vnet_route_all_enabled", false)
    websockets_enabled                = lookup(var.site_config, "websockets_enabled", false)
    worker_count                      = lookup(var.site_config, "worker_count", null)
  }

  dynamic "auth_settings" {
    for_each = var.auth_settings != null ? [var.auth_settings] : []
    content {
      enabled = auth_settings.value.enabled
      active_directory {
        client_id                  = lookup(auth_settings.value.active_directory, "client_id", null)
        allowed_audiences          = lookup(auth_settings.value.active_directory, "allowed_audiences", [])
        client_secret              = lookup(auth_settings.value.active_directory, "client_secret", null)
        client_secret_setting_name = lookup(auth_settings.value.active_directory, "client_secret_setting_name", null)
      }
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters", {})
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", [])
      default_provider               = lookup(auth_settings.value, "default_provider", null)
      facebook {
        app_id                  = lookup(auth_settings.value.facebook, "app_id", null)
        app_secret              = lookup(auth_settings.value.facebook, "app_secret", null)
        app_secret_setting_name = lookup(auth_settings.value.facebook, "app_secret_setting_name", null)
        oauth_scopes            = lookup(auth_settings.value.facebook, "oauth_scopes", [])
      }
      github {
        client_id                  = lookup(auth_settings.value.github, "client_id", null)
        client_secret              = lookup(auth_settings.value.github, "client_secret", null)
        client_secret_setting_name = lookup(auth_settings.value.github, "client_secret_setting_name", null)
        oauth_scopes               = lookup(auth_settings.value.github, "oauth_scopes", [])
      }
      google {
        client_id                  = lookup(auth_settings.value.google, "client_id", null)
        client_secret              = lookup(auth_settings.value.google, "client_secret", null)
        client_secret_setting_name = lookup(auth_settings.value.google, "client_secret_setting_name", null)
        oauth_scopes               = lookup(auth_settings.value.google, "oauth_scopes", [])
      }
      issuer = lookup(auth_settings.value, "issuer", null)
      microsoft {
        client_id                  = lookup(auth_settings.value.microsoft, "client_id", null)
        client_secret              = lookup(auth_settings.value.microsoft, "client_secret", null)
        client_secret_setting_name = lookup(auth_settings.value.microsoft, "client_secret_setting_name", null)
        oauth_scopes               = lookup(auth_settings.value.microsoft, "oauth_scopes", [])
      }
      runtime_version               = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", 72)
      token_store_enabled           = lookup(auth_settings.value, "token_store_enabled", false)
      twitter {
        consumer_key                 = lookup(auth_settings.value.twitter, "consumer_key", null)
        consumer_secret              = lookup(auth_settings.value.twitter, "consumer_secret", null)
        consumer_secret_setting_name = lookup(auth_settings.value.twitter, "consumer_secret_setting_name", null)
      }
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)
    }
  }

  dynamic "auth_settings_v2" {
    for_each = var.auth_settings_v2 != null ? [var.auth_settings_v2] : []
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", false)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", "~1")
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", "RedirectToLoginPage")
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", null)
      excluded_paths                          = lookup(auth_settings_v2.value, "excluded_paths", [])
      require_https                           = lookup(auth_settings_v2.value, "require_https", true)
      http_route_api_prefix                   = lookup(auth_settings_v2.value, "http_route_api_prefix", "/.auth")
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", "NoProxy")
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)
      apple_v2 {
        client_id                  = lookup(auth_settings_v2.value.apple_v2, "client_id", null)
        client_secret_setting_name = lookup(auth_settings_v2.value.apple_v2, "client_secret_setting_name", null)
        login_scopes               = lookup(auth_settings_v2.value.apple_v2, "login_scopes", [])
      }
      active_directory_v2 {
        client_id                            = lookup(auth_settings_v2.value.active_directory_v2, "client_id", null)
        tenant_auth_endpoint                 = lookup(auth_settings_v2.value.active_directory_v2, "tenant_auth_endpoint", null)
        client_secret_setting_name           = lookup(auth_settings_v2.value.active_directory_v2, "client_secret_setting_name", null)
        client_secret_certificate_thumbprint = lookup(auth_settings_v2.value.active_directory_v2, "client_secret_certificate_thumbprint", null)
        jwt_allowed_groups                   = lookup(auth_settings_v2.value.active_directory_v2, "jwt_allowed_groups", [])
        jwt_allowed_client_applications      = lookup(auth_settings_v2.value.active_directory_v2, "jwt_allowed_client_applications", [])
        www_authentication_disabled          = lookup(auth_settings_v2.value.active_directory_v2, "www_authentication_disabled", false)
        allowed_groups                       = lookup(auth_settings_v2.value.active_directory_v2, "allowed_groups", [])
        allowed_identities                   = lookup(auth_settings_v2.value.active_directory_v2, "allowed_identities", [])
        allowed_applications                 = lookup(auth_settings_v2.value.active_directory_v2, "allowed_applications", [])
        login_parameters                     = lookup(auth_settings_v2.value.active_directory_v2, "login_parameters", {})
        allowed_audiences                    = lookup(auth_settings_v2.value.active_directory_v2, "allowed_audiences", [])
      }
      azure_static_web_app_v2 {
        client_id = lookup(auth_settings_v2.value.azure_static_web_app_v2, "client_id", null)
      }
      dynamic "custom_oidc_v2" {
        for_each = lookup(auth_settings_v2.value, "custom_oidc_v2", [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type", null)
          scopes                        = lookup(custom_oidc_v2.value, "scopes", [])
          client_credential_method      = lookup(custom_oidc_v2.value, "client_credential_method", null)
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name", null)
          authorisation_endpoint        = lookup(custom_oidc_v2.value, "authorisation_endpoint", null)
          token_endpoint                = lookup(custom_oidc_v2.value, "token_endpoint", null)
          issuer_endpoint               = lookup(custom_oidc_v2.value, "issuer_endpoint", null)
          certification_uri             = lookup(custom_oidc_v2.value, "certification_uri", null)
        }
      }
      facebook_v2 {
        app_id                  = lookup(auth_settings_v2.value.facebook_v2, "app_id", null)
        app_secret_setting_name = lookup(auth_settings_v2.value.facebook_v2, "app_secret_setting_name", null)
        graph_api_version       = lookup(auth_settings_v2.value.facebook_v2, "graph_api_version", null)
        login_scopes            = lookup(auth_settings_v2.value.facebook_v2, "login_scopes", [])
      }
      github_v2 {
        client_id                  = lookup(auth_settings_v2.value.github_v2, "client_id", null)
        client_secret_setting_name = lookup(auth_settings_v2.value.github_v2, "client_secret_setting_name", null)
        login_scopes               = lookup(auth_settings_v2.value.github_v2, "login_scopes", [])
      }
      google_v2 {
        client_id                  = lookup(auth_settings_v2.value.google_v2, "client_id", null)
        client_secret_setting_name = lookup(auth_settings_v2.value.google_v2, "client_secret_setting_name", null)
        allowed_audiences          = lookup(auth_settings_v2.value.google_v2, "allowed_audiences", [])
        login_scopes               = lookup(auth_settings_v2.value.google_v2, "login_scopes", [])
      }
      microsoft_v2 {
        client_id                  = lookup(auth_settings_v2.value.microsoft_v2, "client_id", null)
        client_secret_setting_name = lookup(auth_settings_v2.value.microsoft_v2, "client_secret_setting_name", null)
        allowed_audiences          = lookup(auth_settings_v2.value.microsoft_v2, "allowed_audiences", [])
        login_scopes               = lookup(auth_settings_v2.value.microsoft_v2, "login_scopes", [])
      }
      twitter_v2 {
        consumer_key                 = lookup(auth_settings_v2.value.twitter_v2, "consumer_key", null)
        consumer_secret_setting_name = lookup(auth_settings_v2.value.twitter_v2, "consumer_secret_setting_name", null)
      }
      login {
        logout_endpoint                   = lookup(auth_settings_v2.value.login, "logout_endpoint", null)
        token_store_enabled               = lookup(auth_settings_v2.value.login, "token_store_enabled", false)
        token_refresh_extension_time      = lookup(auth_settings_v2.value.login, "token_refresh_extension_time", 72)
        token_store_path                  = lookup(auth_settings_v2.value.login, "token_store_path", null)
        token_store_sas_setting_name      = lookup(auth_settings_v2.value.login, "token_store_sas_setting_name", null)
        preserve_url_fragments_for_logins = lookup(auth_settings_v2.value.login, "preserve_url_fragments_for_logins", false)
        allowed_external_redirect_urls    = lookup(auth_settings_v2.value.login, "allowed_external_redirect_urls", [])
        cookie_expiration_convention      = lookup(auth_settings_v2.value.login, "cookie_expiration_convention", "FixedTime")
        cookie_expiration_time            = lookup(auth_settings_v2.value.login, "cookie_expiration_time", "08:00:00")
        validate_nonce                    = lookup(auth_settings_v2.value.login, "validate_nonce", true)
        nonce_expiration_time             = lookup(auth_settings_v2.value.login, "nonce_expiration_time", "00:05:00")
      }
    }
  }

  dynamic "backup" {
    for_each = var.backup != null ? [var.backup] : []
    content {
      name                = backup.value.name
      storage_account_url = backup.value.storage_account_url
      enabled             = lookup(backup.value, "enabled", true)

      schedule {
        frequency_interval       = backup.value.schedule.frequency_interval
        frequency_unit           = backup.value.schedule.frequency_unit
        keep_at_least_one_backup = lookup(backup.value.schedule, "keep_at_least_one_backup", false)
        retention_period_days    = lookup(backup.value.schedule, "retention_period_days", 30)
        start_time               = lookup(backup.value.schedule, "start_time", null)
      }
    }
  }

  builtin_logging_enabled            = var.builtin_logging_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths != null ? var.client_certificate_exclusion_paths : null

  dynamic "connection_string" {
    for_each = var.connection_string
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  enabled                                  = var.enabled
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication_enabled
  functions_extension_version              = var.functions_extension_version
  https_only                               = var.https_only
  public_network_access_enabled            = var.public_network_access_enabled

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  key_vault_reference_identity_id = var.key_vault_reference_identity_id != null ? var.key_vault_reference_identity_id : null

  dynamic "storage_account" {
    for_each = var.storage_account
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }

  dynamic "sticky_settings" {
    for_each = var.sticky_settings != null ? [var.sticky_settings] : []
    content {
      app_setting_names       = lookup(sticky_settings.value, "app_setting_names", [])
      connection_string_names = lookup(sticky_settings.value, "connection_string_names", [])
    }
  }

  virtual_network_subnet_id                      = var.virtual_network_subnet_id != null ? var.virtual_network_subnet_id : null
  vnet_image_pull_enabled                        = var.vnet_image_pull_enabled
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = var.zip_deploy_file != null ? var.zip_deploy_file : null
  tags                                           = var.tags

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    read   = var.read_timeout
    delete = var.delete_timeout
  }
}