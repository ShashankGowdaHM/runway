variable "name" {
  description = "The name of the Container Apps Managed Environment."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "hpaip-stg-common-rg1"
}

variable "location" {
  description = "The Azure location."
  type        = string
}

variable "dapr_application_insights_connection_string" {
  description = "Application Insights connection string for Dapr telemetry."
  type        = string
  default     = null
}

variable "infrastructure_resource_group_name" {
  description = "Platform-managed resource group for infrastructure."
  type        = string
  default     = null
}

variable "infrastructure_subnet_id" {
  description = "Subnet ID for Container Apps Control Plane."
  type        = string
  default     = null
}

variable "internal_load_balancer_enabled" {
  description = "Operate in Internal Load Balancing Mode?"
  type        = bool
  default     = false
}

variable "zone_redundancy_enabled" {
  description = "Enable Zone Redundancy?"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID."
  type        = string
  default     = null
}

variable "logs_destination" {
  description = "Destination for application logs. Valid values: log-analytics, azure-monitor."
  type        = string
  default     = null
}

variable "mutual_tls_enabled" {
  description = "Enable mutual TLS (mTLS)?"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "workload_profiles" {
  description = "List of workload profiles."
  type = list(object({
    name                  = string
    workload_profile_type = string
    maximum_count         = number
    minimum_count         = number
  }))
  default = []
}
