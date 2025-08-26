###############################################
# variables.tf
# Variables for Azure Private Endpoint Module
# With validation, required/optional comments,
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
    condition     = length(var.name) >= 2 && length(var.name) <= 80
    error_message = "Private Endpoint name must be between 2 and 80 characters."
  }
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Private Endpoint."
  type        = string
}

variable "location" {
  description = "The Azure region where the Private Endpoint will be deployed."
  type        = string
}

variable "subnet_id" {
  description = <<EOT
The ID of the Subnet where the Private Endpoint will be placed.
⚠️ IMPORTANT: The subnet must have 'private endpoint network policies' disabled.
EOT
  type = string
}

variable "private_service_connection" {
  description = <<EOT
Configuration block for the private service connection.
Required to define the link between the Private Endpoint and the target service.
EOT
  type = object({
    name                             = string                   # (Required) Name of the private service connection
    is_manual_connection             = bool                     # (Required) Whether the connection requires manual approval
    private_connection_resource_id   = optional(string)          # (Optional) Resource ID of the target service
    private_connection_resource_alias = optional(string)         # (Optional) Alias of the target service (used when ID not available)
    subresource_names                = optional(list(string))    # (Optional) Subresources (e.g., blob, file, sqlServer, vault)
    request_message                  = optional(string)          # (Optional) Message for approval workflow
  })
}

# ---------------------------
# Optional Variables
# ---------------------------

variable "custom_network_interface_name" {
  description = "Custom name for the NIC associated with the Private Endpoint. If null, Azure auto-generates one."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource. Required for governance (env, app, owner, cost_center)."
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_group" {
  description = <<EOT
Configuration for Private DNS Zone Group (optional).
- Links the Private Endpoint to Private DNS Zones for automatic DNS resolution.
EOT
  type = object({
    name                 = string         # (Required if used) DNS zone group name
    private_dns_zone_ids = list(string)   # (Required if used) List of private DNS zone IDs
  })
  default = null
}

variable "ip_configurations" {
  description = <<EOT
Optional static IP configurations for the Private Endpoint.
⚠️ Normally Azure assigns the IP automatically. Use only if static IP is required.
EOT
  type = list(object({
    name               = string           # (Required) Name of the IP config
    private_ip_address = string           # (Required) Private IP address to assign
    subresource_name   = optional(string) # (Optional) Subresource mapping
    member_name        = optional(string) # (Optional) Member name mapping
  }))
  default = []
}
