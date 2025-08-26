# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

resource "azurerm_cognitive_deployment" "model_deployment" {
  name                 = var.name
  cognitive_account_id = var.cognitive_account_id
  dynamic "model" {
    for_each = [1]
    content {
      format = var.model_format
      name   = var.model_name

      # Include only if model_version is set
      # Terraform will exclude this if value is null
      version = var.model_version != null && var.model_version != "" ? var.model_version : null
    }
  }

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
    tier     = var.sku_tier
    size     = var.sku_size
    family   = var.sku_family
  }

  rai_policy_name        = var.rai_policy_name
  version_upgrade_option = var.version_upgrade_option
}
