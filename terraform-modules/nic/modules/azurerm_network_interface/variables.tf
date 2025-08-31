variable "location" {
  description = "The location where the Network Interface should exist."
  type        = string
}

variable "name" {
  description = "The name of the Network Interface."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group."
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "auxiliary_mode" {
  description = "Specifies the auxiliary mode for NVAs."
  type        = string
  default     = null
}

variable "auxiliary_sku" {
  description = "Specifies the auxiliary SKU for NVAs."
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "A list of DNS Servers."
  type        = list(string)
  default     = []
}

variable "edge_zone" {
  description = "Specifies the Edge Zone."
  type        = string
  default     = null
}

variable "ip_forwarding_enabled" {
  description = "Enable IP Forwarding."
  type        = bool
  default     = false
}

variable "accelerated_networking_enabled" {
  description = "Enable Accelerated Networking."
  type        = bool
  default     = false
}

variable "internal_dns_name_label" {
  description = "Internal DNS Name Label."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "ip_configuration" {
  description = "IP Configuration block for the NIC."
  type = object({
    name                                         = string
    subnet_id                                    = string
    private_ip_address_allocation                = string
    private_ip_address                           = optional(string)
    private_ip_address_version                   = optional(string)
    gateway_load_balancer_frontend_ip_configuration_id = optional(string)
    public_ip_address_id                         = optional(string)
    primary                                      = optional(bool)
  })
}
