###############################################
# Azure Storage Account Terraform Module
# Compliant with HP Runway Standards
# - Secure by default (private network rules)
# - Configurable redundancy (LRS, GRS, ZRS, RA-GRS, etc.)
# - Governance enforced via tagging
# - Timeouts included for reliability
###############################################

# ---------------------------
# Provider Configuration
# ---------------------------
# The provider block should be declared at the root module level.
# Example (commented out here for reference):
#
# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

# ---------------------------
# Azure Storage Account Resource
# ---------------------------
resource "azurerm_storage_account" "storage_account" {
  # Name of the storage account (must be globally unique, 3–24 characters, lowercase letters & numbers only).
  name                = var.name

  # Resource group where the storage account will be deployed.
  resource_group_name = var.resource_group_name

  # Azure region for the storage account.
  location = var.location

  # ---------------------------
  # Storage Account SKU
  # ---------------------------
  # account_tier: "Standard" or "Premium"
  # account_replication_type: LRS, ZRS, GRS, RAGRS (e.g., "Standard_LRS")
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  # ---------------------------
  # Network Rules (Optional, but strongly recommended)
  # ---------------------------
  # Defines the network rules for accessing the storage account.
  # Best practice: Default action = "Deny" and allow only trusted IPs/VNETs.
  dynamic "network_rules" {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      # Must be "Allow" or "Deny". Recommended: "Deny".
      default_action             = network_rules.value.default_action
      # List of public IP ranges allowed to access the account.
      ip_rules                   = network_rules.value.ip_rules
      # Subnets (via service endpoints) allowed to access the account.
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
    }
  }

  # ---------------------------
  # Tags (Governance Requirement)
  # ---------------------------
  # Required for cost allocation, ownership, and compliance.
  tags = var.tags

  # ---------------------------
  # Timeouts
  # ---------------------------
  # Explicit timeouts to avoid Terraform hanging indefinitely.
  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    read   = var.read_timeout
    delete = var.delete_timeout
  }
}
