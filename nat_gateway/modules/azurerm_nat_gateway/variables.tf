variable "name" {
  description = "Specifies the name of the NAT Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group in which the NAT Gateway should exist."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the NAT Gateway should exist."
  type        = string
}

variable "idle_timeout_in_minutes" {
  description = "The idle timeout in minutes. Defaults to 4."
  type        = number
  default     = 4
}

variable "sku_name" {
  description = "The SKU for the NAT Gateway. Defaults to 'Standard'."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A mapping of tags to assign to the NAT Gateway."
  type        = map(string)
  default     = {}
}

variable "zones" {
  description = "A list of Availability Zones in which this NAT Gateway should be located."
  type        = list(string)
  default     = []
}
