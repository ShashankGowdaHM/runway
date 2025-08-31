terraform {
source = "git::ssh://git@github.azc.ext.hp.com/HPAIP/terraform-modules.git//azurerm/resources/subnet/modules/azurerm_subnet?ref=master"
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




dependency "resource-group" {
  config_path = "../../resource-group/hpaip-stg-common-rg1"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    name = "hpaip-${local.environment_name}-common-rg1"
  }
}

dependency "virtual-network" {
  config_path = "../../virtual-network/hpaip-stg-aigw-vnet1"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    name = "hpaip-${local.environment_name}-aigw-vnet1"
  }
}



inputs = {

  name = ContainerAppSubnet1

  virtual_network_name = "hpaip-stg-aigw-vnet1"

  subscription_id = ${local.subscription_id}

  location = ${local.location}

  resource_group_name = ${dependency.resource_group.outputs.name}

  address_space = ["10.201.8.0/23"]

  tags = local.resource_tags

}
