######################################################
# Terraform Settings Block
# HP Runway Standards:
# - Pin to minimum required Terraform version
# - Pin provider to same or above current stable release
# - Use official provider source for clarity
######################################################

terraform {
  # Minimum required Terraform version.
  # Using >= 1.6.0 since 1.6 is a stable LTS version.
  required_version = ">= 1.6.0"

  # Define required providers for this module.
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"  # Official AzureRM provider
      version = ">= 4.15.0"          # Use this version or later (matches current stable)
    }
  }
}
