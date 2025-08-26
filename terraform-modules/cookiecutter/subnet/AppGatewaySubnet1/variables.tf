variable "name" {
  description = "The name of the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the subnet"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet"
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet"
  type        = list(string)
}

variable "delegation" {
  description = "Optional delegation block"
  type = object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  })
  default = null
}

variable "default_outbound_access_enabled" {
  description = "Enable default outbound access to the internet for the subnet"
  type        = bool
  default     = true
}

variable "private_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private endpoint on the subnet"
  type        = string
  default     = "Disabled"
}

variable "private_link_service_network_policies_enabled" {
  description = "Enable or Disable network policies for the private link service on the subnet"
  type        = bool
  default     = true
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet"
  type        = list(string)
  default     = []
}

variable "service_endpoint_policy_ids" {
  description = "The list of IDs of Service Endpoint Policies to associate with the subnet"
  type        = list(string)
  default     = []
}

variable "create_timeout" {
  description = "The create timeout for the subnet"
  type        = string
  default     = "30m"
}

variable "update_timeout" {
  description = "The update timeout for the subnet"
  type        = string
  default     = "30m"
}

variable "read_timeout" {
  description = "The read timeout for the subnet"
  type        = string
  default     = "5m"
}

variable "delete_timeout" {
  description = "The delete timeout for the subnet"
  type        = string
  default     = "30m"
}

variable "subscription_id" {
  description = "Subscription id where the subnet is created"
  type        = string
}