/* terraform {
  source = "git::ssh://git@github.azc.ext.hp.com/HPAIP/terraform-modules.git//azurerm/resources/resource_group/modules/azurerm_resource_group?ref=master"
} */

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

inputs = {
  name            = "hpaip-${local.environment_name}-common-rg1"
  subscription_id = "${local.subscription_id}"
  location        = "${local.location}"
  tags            = local.resource_tags
}
