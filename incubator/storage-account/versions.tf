##############################################################
# Terraform & Provider Version Constraints
# HP Runway Compliance:
#  - Specify minimum Terraform version (ensure modern features are available).
#  - Pin provider to current stable or greater for consistency and updates.
#  - Include clear comments and rationale.
##############################################################

terraform {
  # ----------------------------------------------------------
  # Minimum Terraform Core Version
  # ----------------------------------------------------------
  # Requires Terraform 1.13.0 or newer to use latest HCL features 
  # and improvements added in this release.
  # (Released August 20, 2025)
  required_version = ">= 1.13.0" 

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # Pin to the latest stable Azure provider (v4.41.0) or newer
      # to ensure access to newest Azure features and fixes.
      version = ">= 4.41.0"
    }
  }
}
