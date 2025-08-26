variable "name" {
  description = "The name of the Private DNS Zone. Must be a valid domain name."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the resource group where the Private DNS Zone will be created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "soa_record_email" {
  description = "The email contact for the SOA record."
  type        = string
  default     = null
}

variable "soa_expire_time" {
  description = "The expire time for the SOA record."
  type        = number
  default     = 2419200
}

variable "soa_minimum_ttl" {
  description = "The minimum TTL for the SOA record."
  type        = number
  default     = 10
}

variable "soa_refresh_time" {
  description = "The refresh time for the SOA record."
  type        = number
  default     = 3600
}

variable "soa_retry_time" {
  description = "The retry time for the SOA record."
  type        = number
  default     = 300
}

variable "soa_ttl" {
  description = "The TTL for the SOA record."
  type        = number
  default     = 3600
}
