######################################################
# Required Variables
######################################################

variable "name" {
  description = "The name of the Storage Account. Must be unique across Azure."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Storage Account will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where the Storage Account will be created."
  type        = string
}

variable "account_tier" {
  description = "Defines the Tier to use for this Storage Account. Valid options: Standard, Premium."
  type        = string
}

variable "account_replication_type" {
  description = "Defines the type of replication to use for this Storage Account. Valid options: LRS, GRS, RAGRS, ZRS."
  type        = string
}

######################################################
# Optional Variables
######################################################

variable "network_rules" {
  description = <<EOT
Optional network rules for the Storage Account.
- default_action: (Required) The default action of allow or deny when no other rules match.
- ip_rules: (Optional) List of public IP or IP ranges in CIDR format.
- virtual_network_subnet_ids: (Optional) List of Subnet IDs to allow access from.
EOT
  type = object({
    default_action             = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the Storage Account."
  type        = map(string)
  default     = {}
}

######################################################
# Timeouts
######################################################

variable "create_timeout" {
  description = "The duration to wait for create operations. Default is 60m."
  type        = string
  default     = "60m"
}

variable "update_timeout" {
  description = "The duration to wait for update operations. Default is 60m."
  type        = string
  default     = "60m"
}

variable "read_timeout" {
  description = "The duration to wait for read operations. Default is 5m."
  type        = string
  default     = "5m"
}

variable "delete_timeout" {
  description = "The duration to wait for delete operations. Default is 60m."
  type        = string
  default     = "60m"
}
