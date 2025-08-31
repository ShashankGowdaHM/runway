terraform {
  source = "git::ssh://git@github.azc.ext.hp.com/HPAIP/terraform-modules.git//azurerm/resources/security-group/modules/azurerm_network_security_group?ref=master"
}

locals {
  # common_vars   = read_terragrunt_config(find_in_parent_folders("commons_infra.hcl"))
  env_vars          = read_terragrunt_config(find_in_parent_folders("environment.hcl"))
  location_vars     = read_terragrunt_config(find_in_parent_folders("location.hcl"))
  subscription_vars = read_terragrunt_config(find_in_parent_folders("subscription.hcl"))
  org_vars          = read_terragrunt_config(find_in_parent_folders("organization.hcl"))

  environment_name = local.env_vars.locals.environment
  subscription_id  = local.subscription_vars.locals.subscription_id
  location         = local.location_vars.locals.location

  resource_tags = merge(
    local.env_vars.locals.environment_tags,
    local.location_vars.locals.location_tags,
    local.org_vars.locals.org_tags,
    local.org_vars.locals.org_custom_tags,
  )
}

include {
  path = find_in_parent_folders("azure.hcl")
}

dependency "resource_group" {
  config_path                             = "../../resource_group/hpaip-rg1"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    name = "hpaip-${local.environment_name}-common-rg1"
  }
}

inputs = {
  name                = "hpaip-${local.environment_name}-common-linvm1-nsg"
  subscription_id     = "${local.subscription_id}"
  location            = "${local.location}"
  resource_group_name = "${dependency.resource_group.outputs.name}"
  tags                = local.resource_tags
}