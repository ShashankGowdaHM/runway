variable "name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The location of the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "dns_servers" {
  description = "The DNS servers for the virtual network"
  type        = list(string)
  default     = []
}

variable "subnet" {
  description = "The name and address_prefix of the subnet"
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "Tags to be applied to the virtual network"
  type        = map(string)
}

variable "create_timeout" {
  description = "Time to wait for a security group to be created"
  type        = string
  default     = null
}
variable "delete_timeout" {
  description = "Time to wait for a security group to be deleted"
  type        = string
  default     = null
}

variable "subscription_id" {
  description = "Subscription id where the vnet is created"
  type        = string
}
