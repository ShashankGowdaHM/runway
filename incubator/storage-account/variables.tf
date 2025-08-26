######################################################
# variables.tf
# Variables for Azure Storage Account Module
# With validation, defaults, and HP Runway compliance.
######################################################

# ---------------------------
# Required Variables
# ---------------------------

variable "name" {
  description = <<EOT
The name of the Storage Account. Must be globally unique across Azure.
Rules:
- Between 3 and 24 characters.
- Only lowercase letters and numbers allowed.
- Must not contain special characters or uppercase letters.
EOT
  type = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage Account name must be 3-24 characters long, only lowercase letters and numbers."
  }
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Storage Account will be created."
  type        = string

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "Resource group name cannot be empty."
  }
}

variable "location" {
  description = "The Azure region where the Storage Account will be created (e.g., eastus, westeurope)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.location))
    error_message = "Location must be a valid Azure region in lowercase (e.g., eastus, centralindia)."
  }
}

variable "account_tier" {
  description = "Defines the performance tier of the Storage Account. Valid options: Standard, Premium."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  description = <<EOT
Defines the replication strategy for the Storage Account.
Valid options:
- LRS   : Locally Redundant Storage
- ZRS   : Zone-Redundant Storage
- GRS   : Geo-Redundant Storage
- RAGRS : Read-Access Geo-Redundant Storage
EOT
  type = string

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS"], var.account_replication_type)
    error_message = "account_replication_type must be one of: LRS, ZRS, GRS, RAGRS."
  }
}

# ---------------------------
# Optional Variables
# ---------------------------

variable "network_rules" {
  description = <<EOT
Optional network rules for the Storage Account.
⚠️ Best Practice: Restrict access only to known IP ranges or VNets for security.
- default_action: (Required) allow or deny when no rules match.
- ip_rules: (Optional) List of public IPs or CIDR ranges.
- virtual_network_subnet_ids: (Optional) List of Subnet IDs with access.
EOT
  type = object({
    default_action             = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null

  validation {
    condition     = var.network_rules == null || contains(["Allow", "Deny"], var.network_rules.default_action)
    error_message = "default_action in network_rules must be either 'Allow' or 'Deny'."
  }
}

variable "tags" {
  description = <<EOT
Tags to assign to the Storage Account.
⚠️ Required by HP governance standards:
- env         = Environment (dev/test/prod)
- app         = Application name
- owner       = Team or individual responsible
- cost_center = Billing/cost code
EOT
  type    = map(string)
  default = {}
}

# ---------------------------
# Timeout Variables
# ---------------------------

variable "create_timeout" {
  description = "Duration to wait for create operations. Default is 60 minutes."
  type        = string
  default     = "60m"

  validation {
    condition     = can(regex("^[0-9]+m$", var.create_timeout))
    error_message = "create_timeout must be specified in minutes (e.g., 60m)."
  }
}

variable "update_timeout" {
  description = "Duration to wait for update operations. Default is 60 minutes."
  type        = string
  default     = "60m"

  validation {
    condition     = can(regex("^[0-9]+m$", var.update_timeout))
    error_message = "update_timeout must be specified in minutes (e.g., 60m)."
  }
}

variable "read_timeout" {
  description = "Duration to wait for read operations. Default is 5 minutes."
  type        = string
  default     = "5m"

  validation {
    condition     = can(regex("^[0-9]+m$", var.read_timeout))
    error_message = "read_timeout must be specified in minutes (e.g., 5m)."
  }
}

variable "delete_timeout" {
  description = "Duration to wait for delete operations. Default is 60 minutes."
  type        = string
  default     = "60m"

  validation {
    condition     = can(regex("^[0-9]+m$", var.delete_timeout))
    error_message = "delete_timeout must be specified in minutes (e.g., 60m)."
  }
}
