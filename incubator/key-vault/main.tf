###############################################
# Azure Key Vault Terraform Module
# Compliant with HP Runway Standards
# - RBAC-first authorization (no inline policies unless explicitly needed)
# - Soft delete & purge protection enabled
# - Restrictive network ACLs (deny by default)
# - Configurable access policies for least-privilege principle
# - Proper tagging for governance
###############################################

# ---------------------------
# Provider Configuration
# ---------------------------
# The provider block should be defined at the root module level.
# Example (commented out here for reference):
#
# provider "azurerm" {
#   features {
#     key_vault {
#       purge_soft_delete_on_destroy    = true  # Required to avoid accidental data loss
#       recover_soft_deleted_key_vaults = true  # Ensures recovery in case of accidental deletion
#     }
#   }
#   subscription_id = var.subscription_id
# }

# ---------------------------
# Azure Key Vault Resource
# ---------------------------
resource "azurerm_key_vault" "key_vault" {
  # Name must be globally unique, 3-24 characters, only alphanumeric and hyphens
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # Enable VM, Disk, and ARM template deployments to access the Key Vault
  enabled_for_deployment          = var.enabled_for_deployment          # (Optional) Recommended: false unless needed
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption     # (Optional) Recommended: false unless required for Azure Disk Encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment # (Optional) Recommended: false unless using ARM templates

  # RBAC-based access control is recommended over access policies
  enable_rbac_authorization = var.enable_rbac_authorization # HP Runway: Should be true (access policies discouraged)

  # Tenant and subscription scope
  tenant_id = var.tenant_id

  # Security standards: Enable soft delete + purge protection
  soft_delete_retention_days = var.soft_delete_retention_days  # Must be between 7–90
  purge_protection_enabled   = var.purge_protection_enabled    # Should always be true (cannot be disabled after enablement)

  # Networking: public access should be disabled unless absolutely necessary
  public_network_access_enabled = var.public_network_access_enabled # HP Runway: false preferred, use private endpoints

  # SKU: Standard (recommended) or Premium (if HSM required)
  sku_name = var.sku_name

  # ---------------------------
  # Access Policies (deprecated if using RBAC)
  # ---------------------------
  dynamic "access_policy" {
    for_each = var.access_policy != null ? var.access_policy : []
    content {
      tenant_id               = access_policy.value.tenant_id
      object_id               = access_policy.value.object_id
      application_id          = lookup(access_policy.value, "application_id", null)

      # Permissions are lists of allowed operations (least-privilege principle applies)
      certificate_permissions = lookup(access_policy.value, "certificate_permissions", [])
      key_permissions         = lookup(access_policy.value, "key_permissions", [])
      secret_permissions      = lookup(access_policy.value, "secret_permissions", [])
      storage_permissions     = lookup(access_policy.value, "storage_permissions", [])
    }
  }

  # ---------------------------
  # Network ACLs (restrict access)
  # ---------------------------
  dynamic "network_acls" {
    for_each = var.network_acls != null ? [var.network_acls] : []
    content {
      # Possible values: "AzureServices", "None"
      bypass         = network_acls.value.bypass

      # "Deny" by default is strongly recommended
      default_action = network_acls.value.default_action

      # Restrict allowed IP ranges and VNET subnets
      ip_rules                   = lookup(network_acls.value, "ip_rules", [])
      virtual_network_subnet_ids = lookup(network_acls.value, "virtual_network_subnet_ids", [])
    }
  }

  # ---------------------------
  # Contact Information (Optional governance field)
  # ---------------------------
  dynamic "contact" {
    for_each = var.contact != null ? var.contact : []
    content {
      email = contact.value.email
      name  = lookup(contact.value, "name", null)
      phone = lookup(contact.value, "phone", null)
    }
  }

  # ---------------------------
  # Tags (Required for governance)
  # ---------------------------
  tags = var.tags

  # ---------------------------
  # Timeouts (good practice for long-running deployments)
  # ---------------------------
  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    read   = var.read_timeout
    delete = var.delete_timeout
  }
}
