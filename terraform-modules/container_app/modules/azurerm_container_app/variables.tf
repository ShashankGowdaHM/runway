variable "container_app_environment_id" {
  description = "The ID of the Container App Environment."
  type        = string
}

variable "name" {
  description = "The name of the Container App."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "revision_mode" {
  description = "The revision mode of the Container App."
  type        = string
  default     = "Single"
}

variable "template" {
  description = "The template configuration for the Container App."
  type = object({
    init_containers = optional(list(object({
      name            = string
      image           = string
      args            = optional(list(string))
      command         = optional(list(string))
      cpu             = optional(number)
      memory          = optional(string) # should be twice the value of cpu
      env             = optional(list(object({
        name        = string
        value       = optional(string)
        secret_name = optional(string)
      })), [])
      volume_mounts   = optional(list(object({
        name      = string
        path      = string
        sub_path  = optional(string)
      })), [])
    })), [])

    container = object({
      args            = optional(list(string))
      command         = optional(list(string))
      name   = string
      image  = string
      cpu             = optional(number)
      memory          = optional(string) # should be twice the value of cpu
      env             = optional(list(object({
        name        = string
        value       = optional(string)
        secret_name = optional(string)
      })), [])
      liveness_probe = optional(object({
      failure_count_threshold = optional(number, 3)
      header = optional(object({
        name  = string
        value = string
      }), null)
      host     = optional(string)
      inital_delay = optional(number, 1)
      interval_seconds = optional(number, 10)
      path      = optional(string)
      port      = number
      timeout = optional(number, 1)
      transport = string # Required field
    }), null)
    readiness_probe = optional(object({
      failure_count_threshold = optional(number, 3)
      header = optional(object({
        name  = string
        value = string
      }), null)
      host     = optional(string)
      inital_delay = optional(number, 1)
      interval_seconds = optional(number, 10)
      path      = optional(string)
      port      = number
      success_count_threshold = optional(number, 3)
      timeout = optional(number, 1)
      transport = string # Required field
    }), null)
    startup_probe = optional(object({
      failure_count_threshold = optional(number, 3)
      header = optional(object({
        name  = string
        value = string
      }), null)
      host     = optional(string)
      inital_delay = optional(number, 1)
      interval_seconds = optional(number, 10)
      path      = optional(string)
      port      = number
      timeout = optional(number, 1)
      transport = string # Required field
    }), null)
    volume_mounts   = optional(list(object({
        name      = string
        path      = string
        sub_path  = optional(string)
      })), [])
    })

    min_replicas = optional(number, null)
    max_replicas = optional(number, null)
    azure_queue_scale_rule = optional(object({
      queue_name = string
      queue_length = number
      name = string
      authentication = object({
        secret_name = string
        trigger_parameter = string
      })
    }), null)
    custom_scale_rule = optional(object({
      name = string
      custom_rule_type = string
      metadata = map(string)
      authentication = optional(object({
        secret_name = string
        trigger_parameter = string
      }), null)
    }), null)
    http_scale_rule = optional(object({
      concurrent_requests = string
      name                = string
      authentication = optional(object({
        secret_name = string
        trigger_parameter = string
      }), null)
    }), null)
    tcp_scale_rule = optional(object({
      concurrent_requests = string
      name                = string
      authentication = optional(object({
        secret_name = string
        trigger_parameter = string
      }), null)
    }), null)
    revision_suffix = optional(string) # Optional revision identifier
    volume = optional(list(object({
      name = string
      storage_name = optional(string)
      storage_type = optional(string, "EmptyDir")
    })), [])
    
  })
}

variable "dapr" {
  description = "The Dapr configuration for the Container App."
  type        = object({
    app_id   = string
    app_port = optional(number) # The port which the application is listening on. This is the same as the ingress port.
    app_protocol = optional(string, "http") # The protocol used by the application. Default is http.
  })
  default     = null
}

variable "identity" {
  description = "The identity configuration."
  type        = object({
    type         = string # The type of managed identity to assign. Possible values are SystemAssigned, UserAssigned, and SystemAssigned, UserAssigned (to enable both).
    identity_ids = optional(list(string), null)
  })
  default     = null
}

variable "ingress" {
  description = "The ingress configuration."
  type = object({
    allow_insecure_connections = optional(bool, false) # Allow insecure connections
    fqdn = optional(string) # Fully qualified domain name
    external_enabled  = optional(bool, false) # Enable external access
    ip_security_restriction = optional(list(object({
      name    = string
      action  = string
      description = optional(string)
      ip_address_range = string
    })), [])
    target_port       = number
    exposed_port     = optional(number) # Port to expose. can only be specified when transport is set to tcp
    traffic_weight = list(object({
      label            = optional(string)
      latest_revision   = optional(bool, false) # Ensure this is always available
      revision_suffix   = optional(string) # Optional revision identifier
      percentage        = number
    }))
    transport        = optional(string, "auto") # The transport protocol. Default is auto.
    client_certificate_mode = optional(string) # The client certificate mode. Possible values are require, accept, and ignore.
  })
  default     = null
}

variable "registry" {
  description = "The container registry configuration."
  type        = object({
    server               = string
    identity            = optional(string)
    username             = optional(string)
    password_secret_name = optional(string)
  })
  default     = null
}

variable "secret" {
  description = "Secrets for the Container App."
  type = list(object({
    name                = string
    identity            = optional(string)
    key_vault_secret_id = optional(string)
    value               = optional(string)
  }))
  default = []
}

variable "workload_profile_name" {
  description = "The workload profile name."
  type        = string
  default     = null
}

variable "max_inactive_revisions" {
  description = "Maximum number of inactive revisions."
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags to assign to the Container App."
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  description = "The subscription ID."
  type        = string
}