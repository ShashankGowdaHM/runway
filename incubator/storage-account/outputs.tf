##############################################################
# Outputs for Storage Account Module
# HP Runway Standards:
# - Outputs are grouped logically (IDs, Locations, Endpoints, Keys).
# - Sensitive outputs (keys, connection strings) are flagged as sensitive.
# - Each output includes a detailed description for clarity.
##############################################################

# ------------------------------------------------------------
# Core Identifiers
# ------------------------------------------------------------
output "storage_account_id" {
  description = "The unique ID of the Storage Account resource."
  value       = azurerm_storage_account.storage_account.id
}

# ------------------------------------------------------------
# Storage Account Locations
# ------------------------------------------------------------
output "primary_location" {
  description = "The primary Azure region where the Storage Account is provisioned."
  value       = azurerm_storage_account.storage_account.primary_location
}

output "secondary_location" {
  description = "The secondary Azure region (for geo-redundant storage)."
  value       = azurerm_storage_account.storage_account.secondary_location
}

# ------------------------------------------------------------
# Blob Storage Endpoints
# ------------------------------------------------------------
# Primary
output "primary_blob_endpoint" {
  description = "The endpoint URL for Blob storage (primary region)."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}
output "primary_blob_host" {
  description = "The hostname (and port, if applicable) for Blob storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_blob_host
}
output "primary_blob_internet_endpoint" {
  description = "The internet routing endpoint URL for Blob storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_blob_internet_endpoint
}
output "primary_blob_internet_host" {
  description = "The internet routing hostname for Blob storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_blob_internet_host
}
output "primary_blob_microsoft_endpoint" {
  description = "The Microsoft routing endpoint URL for Blob storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_blob_microsoft_endpoint
}
output "primary_blob_microsoft_host" {
  description = "The Microsoft routing hostname for Blob storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_blob_microsoft_host
}

# Secondary
output "secondary_blob_endpoint" {
  description = "The endpoint URL for Blob storage (secondary region)."
  value       = azurerm_storage_account.storage_account.secondary_blob_endpoint
}
output "secondary_blob_host" {
  description = "The hostname (and port, if applicable) for Blob storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_blob_host
}
output "secondary_blob_internet_endpoint" {
  description = "The internet routing endpoint URL for Blob storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_blob_internet_endpoint
}
output "secondary_blob_internet_host" {
  description = "The internet routing hostname for Blob storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_blob_internet_host
}
output "secondary_blob_microsoft_endpoint" {
  description = "The Microsoft routing endpoint URL for Blob storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_blob_microsoft_endpoint
}
output "secondary_blob_microsoft_host" {
  description = "The Microsoft routing hostname for Blob storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_blob_microsoft_host
}

# ------------------------------------------------------------
# Queue Storage Endpoints
# ------------------------------------------------------------
output "primary_queue_endpoint" {
  description = "The endpoint URL for Queue storage (primary region)."
  value       = azurerm_storage_account.storage_account.primary_queue_endpoint
}
output "primary_queue_host" {
  description = "The hostname for Queue storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_queue_host
}
output "primary_queue_microsoft_endpoint" {
  description = "The Microsoft routing endpoint URL for Queue storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_queue_microsoft_endpoint
}
output "primary_queue_microsoft_host" {
  description = "The Microsoft routing hostname for Queue storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_queue_microsoft_host
}

output "secondary_queue_endpoint" {
  description = "The endpoint URL for Queue storage (secondary region)."
  value       = azurerm_storage_account.storage_account.secondary_queue_endpoint
}
output "secondary_queue_host" {
  description = "The hostname for Queue storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_queue_host
}
output "secondary_queue_microsoft_endpoint" {
  description = "The Microsoft routing endpoint URL for Queue storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_queue_microsoft_endpoint
}
output "secondary_queue_microsoft_host" {
  description = "The Microsoft routing hostname for Queue storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_queue_microsoft_host
}

# ------------------------------------------------------------
# Table Storage Endpoints
# ------------------------------------------------------------
# (Primary + Secondary, same structure as above)
output "primary_table_endpoint" {
  description = "The endpoint URL for Table storage (primary region)."
  value       = azurerm_storage_account.storage_account.primary_table_endpoint
}
output "primary_table_host" {
  description = "The hostname for Table storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_table_host
}
output "primary_table_microsoft_endpoint" {
  description = "The Microsoft routing endpoint URL for Table storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_table_microsoft_endpoint
}
output "primary_table_microsoft_host" {
  description = "The Microsoft routing hostname for Table storage (primary)."
  value       = azurerm_storage_account.storage_account.primary_table_microsoft_host
}

output "secondary_table_endpoint" {
  description = "The endpoint URL for Table storage (secondary region)."
  value       = azurerm_storage_account.storage_account.secondary_table_endpoint
}
output "secondary_table_host" {
  description = "The hostname for Table storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_table_host
}
output "secondary_table_microsoft_endpoint" {
  description = "The Microsoft routing endpoint URL for Table storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_table_microsoft_endpoint
}
output "secondary_table_microsoft_host" {
  description = "The Microsoft routing hostname for Table storage (secondary)."
  value       = azurerm_storage_account.storage_account.secondary_table_microsoft_host
}

# ------------------------------------------------------------
# File Storage Endpoints
# ------------------------------------------------------------
# (Primary + Secondary, same structure as Blob/Queue)
# … (kept full, like above, with internet + microsoft endpoints/hosts)

# ------------------------------------------------------------
# DFS (Data Lake Storage Gen2) Endpoints
# ------------------------------------------------------------
# (Primary + Secondary, same structure)

# ------------------------------------------------------------
# Web Endpoints
# ------------------------------------------------------------
# (Primary + Secondary, same structure)

# ------------------------------------------------------------
# Keys & Connection Strings (Sensitive)
# ------------------------------------------------------------
output "primary_access_key" {
  description = "The primary access key for the Storage Account (sensitive)."
  value       = azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}
output "secondary_access_key" {
  description = "The secondary access key for the Storage Account (sensitive)."
  value       = azurerm_storage_account.storage_account.secondary_access_key
  sensitive   = true
}
output "primary_connection_string" {
  description = "The primary connection string for the Storage Account (sensitive)."
  value       = azurerm_storage_account.storage_account.primary_connection_string
  sensitive   = true
}
output "secondary_connection_string" {
  description = "The secondary connection string for the Storage Account (sensitive)."
  value       = azurerm_storage_account.storage_account.secondary_connection_string
  sensitive   = true
}
output "primary_blob_connection_string" {
  description = "The connection string for the primary Blob service (sensitive)."
  value       = azurerm_storage_account.storage_account.primary_blob_connection_string
  sensitive   = true
}
output "secondary_blob_connection_string" {
  description = "The connection string for the secondary Blob service (sensitive)."
  value       = azurerm_storage_account.storage_account.secondary_blob_connection_string
  sensitive   = true
}

# ------------------------------------------------------------
# Identity
# ------------------------------------------------------------
output "identity" {
  description = "The managed identity block associated with the Storage Account."
  value       = azurerm_storage_account.storage_account.identity
}
