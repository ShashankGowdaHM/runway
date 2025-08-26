###############################################
# variables.tf
# Variables for Azure Key Vault Module
# With validation, required/optional comments,
# defaults, and HP Runway compliance standards.
###############################################

# ---------------------------
# Required Variables
# ---------------------------

variable "name" {
  description = <<EOT
Specifies the name of the Key Vault.
- Must be globally unique (3–24 characters, alphanumeric + hyphens).
- Changing forces a new resource.
- Vault must be purged before reusing the name.
EOT
  type = string

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 24
    error_message = "Key Vault name must be 3–24 characters long."
  }
}

variable "location" {
  description = "Azure region where the Key Vault will be deployed (e.g., eastus, westeurope)."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Key Vault will be created."
  type        = string
}

variable "sku_name" {
  description = "The SKU used for this Key Vault. Allowed: `standard`, `premium`. Premium supports HSM."
  type        = string

  validation {
    condition     = contains(["standard", "premium"], lower(var.sku_name))
    error_message = "sku_name must be either 'standard' or 'premium'."
  }
}

variable "tenant_id" {
  description = "Azure AD Tenant ID used for authentication with the Key Vault."
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID where the Key Vault will be deployed."
  type        = string
}

# ---------------------------
# Optional Variables
# ---------------------------

variable "access_policy" {
  description = "List of access_policy objects (up to 1024). Avoid if using RBAC (recommended)."
  type = list(object({
    tenant_id               = string
    object_id               = string
    application_id          = optional(string)
    certificate_permissions = optional(list(string))
    key_permissions         = optional(list(string))
    secret_permissions      = optional(list(string))
    storage_permissions     = optional(list(string))
  }))
  default = []
}

variable "enabled_for_deployment" {
  description = "Allow Azure VMs to retrieve certificates as secrets. Default = false."
  type        = bool
  default     = false
}

variable "enabled_for_disk_encryption" {
  description = "Allow Azure Disk Encryption to retrieve secrets and unwrap keys. Default = false."
  type        = bool
  default     = false
}

variable "enabled_for_template_deployment" {
  description = "Allow ARM templates to retrieve secrets. Default = false."
  type        = bool
  default     = false
}

variable "enable_rbac_authorization" {
  description = "Enable RBAC for Key Vault access. Recommended = true. Default = false."
  type        = bool
  default     = false
}

variable "network_acls" {
  description = <<EOT
Network ACL rules for Key Vault.
- bypass: Can be 'AzureServices' or 'None'.
- default_action: Must be 'Allow' or 'Deny'. Recommended: 'Deny'.
- ip_rules: Optional list of allowed public IPs.
- virtual_network_subnet_ids: Optional list of subnet IDs.
EOT
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null

  validation {
    condition     = var.network_acls == null || contains(["AzureServices", "None"], var.network_acls.bypass)
    error_message = "network_acls.bypass must be 'AzureServices' or 'None'."
  }

  validation {
    condition     = var.network_acls == null || contains(["Allow", "Deny"], var.network_acls.default_action)
    error_message = "network_acls.default_action must be 'Allow' or 'Deny'."
  }
}

variable "purge_protection_enabled" {
  description = "Enable purge protection (cannot be disabled after being set). Default = false (Recommended = true)."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Allow public network access? Default = true. Recommended = false (use private endpoints)."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Retention in days for soft-deleted items. Allowed: 7–90. Default = 90."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "contact" {
  description = "Optional list of contact objects for alerts (email required)."
  type = list(object({
    email = string
    name  = optional(string)
    phone = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Resource tags (e.g., environment, cost_center, owner). Required for governance."
  type        = map(string)
  default     = {}
}

# ---------------------------
# Timeouts (Optional, Recommended)
# ---------------------------

variable "create_timeout" {
  description = "Timeout for creating the Key Vault. Default = 30m."
  type        = string
  default     = "30m"
}

variable "update_timeout" {
  description = "Timeout for updating the Key Vault. Default = 30m."
  type        = string
  default     = "30m"
}

variable "read_timeout" {
  description = "Timeout for reading the Key Vault. Default = 5m."
  type        = string
  default     = "5m"
}

variable "delete_timeout" {
  description = "Timeout for deleting the Key Vault. Default = 30m."
  type        = string
  default     = "30m"
}
