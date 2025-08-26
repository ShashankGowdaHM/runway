variable "name" {
  description = "Specifies the Name of the Private Endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "The Azure region where the Private Endpoint should exist"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the Subnet for the Private Endpoint"
  type        = string
}

variable "custom_network_interface_name" {
  description = "Custom name for the network interface"
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_group" {
  description = "A block specifying private DNS zone group configuration"
  type = object({
    name                  = string
    private_dns_zone_ids  = list(string)
  })
  default = null
}

variable "private_service_connection" {
  description = "The private service connection configuration"
  type = object({
    name                           = string
    is_manual_connection           = bool
    private_connection_resource_id = optional(string)
    private_connection_resource_alias = optional(string)
    subresource_names              = optional(list(string))
    request_message                = optional(string)
  })
}

variable "ip_configurations" {
  description = "Optional static IP configurations"
  type = list(object({
    name               = string
    private_ip_address = string
    subresource_name   = optional(string)
    member_name        = optional(string)
  }))
  default = []
}
