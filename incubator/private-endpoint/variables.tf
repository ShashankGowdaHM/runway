###############################################
# variables.tf
# Variables for Azure Private Endpoint Module
# With validation, default values,
# and HP Runway compliance standards.
###############################################

# ---------------------------
# Required Variables
# ---------------------------

variable "name" {
  description = <<EOT
Specifies the name of the Private Endpoint.
- Must be unique within the resource group.
- 2–80 characters, only letters, numbers, underscores, periods, or hyphens.
EOT
  type = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]{2,80}$", var.name))
    error_message = "Private Endpoint name must be 2–80 characters long and contain only letters, numbers, underscores, periods, or hyphens."
  }
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Private Endpoint."
  type        = string

  validation {
    condition     = length(var.resource_group_name) > 0
    error_message = "resource_group_name cannot be empty."
  }
}

variable "location" {
  description = "The Azure region where the Private Endpoint will be deployed."
  type        = string

  validation {
    condition     = length(var.location) > 0
    error_message = "location cannot be empty."
  }
}

variable "subnet_id" {
  description = <<EOT
The ID of the Subnet where the Private Endpoint will be placed.
⚠️ IMPORTANT: The subnet must have 'private endpoint network policies' disabled.
EOT
  type = string

  validation {
    condition     = can(regex("^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/virtualNetworks/.+/subnets/.+$", var.subnet_id))
    error_message = "subnet_id must be a valid subnet resource ID."
  }
}

variable "private_service_connection" {
  description = <<EOT
Configuration block for the private service connection.
Defines the link between the Private Endpoint and the target service.
EOT
  type = object({
    name                              = string                   # (Required) Name of the private service connection
    is_manual_connection              = bool                     # (Required) Whether the connection requires manual approval
    private_connection_resource_id    = optional(string)          # (Optional) Resource ID of the target service
    private_connection_resource_alias = optional(string)          # (Optional) Alias of the target service (used when ID not available)
    subresource_names                 = optional(list(string))    # (Optional) Subresources (e.g., blob, file, sqlServer, vault)
    request_message                   = optional(string)          # (Optional) Message for approval workflow
  })
}

# ---------------------------
# Optional Variables
# ---------------------------

variable "custom_network_interface_name" {
  description = <<EOT
Custom name for the NIC associated with the Private Endpoint.
- Default: null → Azure auto-generates a NIC name.
- Must be 1–80 characters, only letters, numbers, underscores, periods, or hyphens.
EOT
  type    = string
  default = null

  validation {
    condition     = var.custom_network_interface_name == null || can(regex("^[a-zA-Z0-9._-]{1,80}$", var.custom_network_interface_name))
    error_message = "custom_network_interface_name must be 1–80 characters long and contain only letters, numbers, underscores, periods, or hyphens."
  }
}

variable "tags" {
  description = <<EOT
A mapping of tags to assign to the resource.
Required for governance (env, app, owner, cost_center).
EOT
  type    = map(string)
  default = {}

  validation {
    condition     = length(keys(var.tags)) == 0 || alltrue([for k, v in var.tags : length(k) > 0 && length(v) > 0])
    error_message = "All tag keys and values must be non-empty strings."
  }
}

variable "private_dns_zone_group" {
  description = <<EOT
Configuration for Private DNS Zone Group.
- Links the Private Endpoint to Private DNS Zones for automatic DNS resolution.
- Default: null → no DNS zone group created.
EOT
  type = object({
    name                 = string       # (Required if used) DNS zone group name
    private_dns_zone_ids = list(string) # (Required if used) List of private DNS zone IDs
  })
  default = null
}

variable "ip_configurations" {
  description = <<EOT
Optional static IP configurations for the Private Endpoint.
⚠️ Normally Azure assigns the IP automatically. Use only if static IP is required.
EOT
  type = list(object({
    name               = string           # (Required) Name of the IP configuration
    private_ip_address = string           # (Required) Private IP address to assign
    subresource_name   = optional(string) # (Optional) Subresource mapping
    member_name        = optional(string) # (Optional) Member name mapping
  }))
  default = []

  validation {
    condition = alltrue([
      for ip in var.ip_configurations : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", ip.private_ip_address))
    ])
    error_message = "Each ip_configurations.private_ip_address must be a valid IPv4 address."
  }
}
