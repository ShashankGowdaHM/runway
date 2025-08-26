##############################################################
# Terraform Settings
# HP Runway Standards:
#  - Define minimum required Terraform CLI version.
#  - Pin provider versions to the current stable release (or above).
#  - Ensure reproducibility and compatibility across teams/environments.
##############################################################

terraform {
  # Enforce Terraform CLI version for consistent behavior across environments.
  # Current stable as of Aug 2025 is v1.9.6.
  # Using >= ensures future patch versions are also compatible.
  required_version = ">= 1.9.6"

  required_providers {
    # Azure Resource Manager (azurerm) Provider
    # Source: HashiCorp official registry
    # Current stable as of Aug 2025 is v4.18.0
    # Use >= to allow seamless upgrades to newer minor/patch releases.
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.18.0"
    }

    # (Optional) Random provider – often used for unique suffixes or secrets.
    # Included here as part of HP Runway baseline standards.
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }

    # (Optional) Null provider – helps with testing and orchestration.
    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.3"
    }

    # (Optional) TLS provider – for managing SSL/TLS certificates.
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.5"
    }
  }
}
