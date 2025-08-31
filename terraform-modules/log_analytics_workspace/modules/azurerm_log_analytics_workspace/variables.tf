variable "name" {
  description = "Specifies the name of the Log Analytics Workspace."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Log Analytics workspace is created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "allow_resource_only_permissions" {
  description = "Specifies if the Log Analytics Workspace allows users to access data associated with resources they have permission to view."
  type        = bool
  default     = true
}

variable "local_authentication_disabled" {
  description = "Specifies if the Log Analytics workspace should enforce authentication using Azure AD."
  type        = bool
  default     = false
}

variable "sku" {
  description = "Specifies the SKU of the Log Analytics Workspace."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The workspace data retention in days (between 30 and 730)."
  type        = number
  default     = 30
}

variable "daily_quota_gb" {
  description = "The workspace daily quota for ingestion in GB (-1 for unlimited)."
  type        = number
  default     = -1
}

variable "cmk_for_query_forced" {
  description = "Is Customer Managed Storage mandatory for query management?"
  type        = bool
  default     = false
}

variable "internet_ingestion_enabled" {
  description = "Should the Log Analytics Workspace support ingestion over the Public Internet?"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Should the Log Analytics Workspace support querying over the Public Internet?"
  type        = bool
  default     = true
}

variable "reservation_capacity_in_gb_per_day" {
  description = "The capacity reservation level in GB for this workspace (100, 200, ..., 5000)."
  type        = number
  default     = null
}

variable "data_collection_rule_id" {
  description = "The ID of the Data Collection Rule to use for this workspace."
  type        = string
  default     = null
}

variable "immediate_data_purge_on_30_days_enabled" {
  description = "Whether to remove the data in the Log Analytics Workspace immediately after 30 days."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "identity" {
  description = "An identity block for the Log Analytics Workspace."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "subscription_id" {
  description = "The subscription ID in which the Log Analytics workspace is created."
  type        = string
}