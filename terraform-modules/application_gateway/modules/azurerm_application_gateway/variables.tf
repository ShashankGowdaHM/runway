variable "name" {
  description = "The name of the Application Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Application Gateway."
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "location" {
  description = "The Azure region where the Application Gateway should exist."
  type        = string
}

variable "backend_address_pools" {
  description = "List of backend address pools."
  type = list(object({
    name        = string
    fqdns       = optional(list(string))
    ip_addresses = optional(list(string))
  }))
}

variable "backend_http_settings" {
  description = "List of backend HTTP settings."
  type = list(object({
    name                             = string
    cookie_based_affinity            = string
    affinity_cookie_name             = optional(string)
    path                             = optional(string)
    port                             = number
    probe_name                      = optional(string)
    protocol                        = string
    request_timeout                 = optional(number)
    host_name                      = optional(string)
    pick_host_name_from_backend_address = optional(bool)
    authentication_certificate      = optional(list(object({ name = string })))
    trusted_root_certificate_names  = optional(list(string))
    connection_draining             = optional(object({
      enabled         = bool
      drain_timeout_sec = number
    }))
  }))
}

variable "frontend_ip_configurations" {
  description = "List of frontend IP configurations."
  type = list(object({
    name                      = string
    subnet_id                 = optional(string)
    private_ip_address        = optional(string)
    public_ip_address_id      = optional(string)
    private_ip_address_allocation = optional(string)
    private_link_configuration_name = optional(string)
  }))
}

variable "frontend_ports" {
  description = "List of frontend ports."
  type = list(object({
    name = string
    port = number
  }))
}

variable "gateway_ip_configurations" {
  description = "List of gateway IP configurations."
  type = list(object({
    name      = string
    subnet_id = string
  }))
}

variable "http_listeners" {
  description = "List of HTTP listeners."
  type = list(object({
    name                      = string
    frontend_ip_configuration_name = string
    frontend_port_name        = string
    host_name                 = optional(string)
    host_names                = optional(list(string))
    protocol                  = string
    require_sni               = optional(bool)
    ssl_certificate_name      = optional(string)
    custom_error_configuration = optional(list(object({}))) # Simplified
    firewall_policy_id        = optional(string)
    ssl_profile_name          = optional(string)
  }))
}

variable "request_routing_rules" {
  description = "List of request routing rules."
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    redirect_configuration_name = optional(string)
    rewrite_rule_set_name       = optional(string)
    url_path_map_name           = optional(string)
    priority                    = optional(number)
  }))
}

variable "sku" {
  description = "SKU block for the Application Gateway."
  type = object({
    name     = string
    tier     = string
    capacity = optional(number)
  })
}

variable "fips_enabled" {
  description = "Is FIPS enabled on the Application Gateway?"
  type        = bool
  default     = false
}

variable "global" {
  description = "Global block for request and response buffering."
  type = object({
    request_buffering_enabled  = bool
    response_buffering_enabled = bool
  })
  default = null
}

variable "identity" {
  description = "Identity block for user-assigned managed identity."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "tags" {
  description = "Tags to assign to the resource."
  type        = map(string)
  default     = {}
}
