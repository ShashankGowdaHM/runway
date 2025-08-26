variable "name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "subscription_id" {
  description = "Subscription id where the resource group is created"
  type        = string
}

variable "tags" {
  description = "A mapping of tags assigned to the resource group"
  type        = map(string)
  default     = {}
}