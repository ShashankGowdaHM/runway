##############################################################
# Terraform and Provider Versions
# HP Runway Standards:
# - Always pin providers to stable versions (>= latest tested release).
# - Specify minimum Terraform version to ensure compatibility.
# - Include required_providers block for clarity and reproducibility.
##############################################################

terraform {
  # ----------------------------------------------------------
  # Required Terraform Core Version
  # ----------------------------------------------------------
  # Ensures that the configuration is only run with Terraform CLI
  # versions that are compatible with this module.
  # Pin to a safe minimum (>= 1.5.0) since older 0.13 is deprecated.
  # Current stable release (Aug 2025) is Terraform 1.9.x.
  # ----------------------------------------------------------
  required_version = ">= 1.5.0"

  # ----------------------------------------------------------
  # Required Providers
  # ----------------------------------------------------------
  # Defines external providers needed for this module.
  # Pinning to a specific major/minor ensures consistent behavior
  # across environments and prevents breaking changes.
  # ----------------------------------------------------------
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Use >= latest stable major/minor tested release.
      # Version 4.15.0 was given; latest stable (Aug 2025) is 4.16.0+.
      # Pin to >= 4.15.0 for safety while allowing upgrades.
      version = ">= 4.15.0"
    }
  }
}
