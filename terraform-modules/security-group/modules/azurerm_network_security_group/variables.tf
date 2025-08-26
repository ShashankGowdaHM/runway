variable "name" {
  description = "The name of the network security group"
  type        = string
}

variable "location" {
  description = "The location of the network security group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "subscription_id" {
  description = "Subscription id where the security group is created"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "security_rule" {
  description = "List of security rules for the network security group"
  type = list(object({
    name                         = string
    description                  = optional(string, "")
    protocol                     = string
    source_port_range            = optional(string)
    source_port_ranges           = optional(list(string))
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefix   = optional(string)
    destination_address_prefixes = optional(list(string))
    access                       = string
    priority                     = number
    direction                    = string
  }))
  default = []
}