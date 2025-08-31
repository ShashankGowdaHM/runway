# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load environment-level variables
  env_vars          = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  # commons_vars = read_terragrunt_config(find_in_parent_folders("commons.hcl"))

  # Automatically load site-level variables

  # Extract the variables we need for easy access
  subscription_id  = local.subscription_vars.locals.subscription_id
  environment_name = local.env_vars.locals.environment
  # app_name         = local.commons_vars.locals.app_name
  # resource_group_name = local.env_vars.locals.resource_group_name
}


# Configure Terragrunt to automatically store tfstate files in an Blob Storage container
remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    subscription_id      = local.subscription_id
    resource_group_name  = "hpaip-${local.environment_name}-common-rg1"
    storage_account_name = format("hpaip%scommonst1", local.environment_name)
    container_name       = "tfstate"
    key                  = format("%s/terraform.tfstate", path_relative_to_include())
    client_id            = get_env("TF_VAR_client_id")
    client_secret        = get_env("TF_VAR_client_secret")
    tenant_id            = get_env("TF_VAR_tenant_id")
  }
}

# Generate an Azure provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
    subscription_id = "${local.subscription_id}"
    client_id      = var.client_id
    client_secret  = var.client_secret
    tenant_id      = var.tenant_id
}
variable "client_id" {
    sensitive = true
}
variable "client_secret" {
    sensitive = true
}
variable "tenant_id" {
    sensitive = true
}
EOF
}

terraform {
  # Force Terraform to keep trying to acquire a lock for
  # up to 20 minutes if someone else already has the lock
  extra_arguments "retry_lock" {
    commands = get_terraform_commands_that_need_locking()

    arguments = [
      "-lock-timeout=20m"
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.env_vars.locals
)
