terraform {
source = "git::ssh://git@github.azc.ext.hp.com/HPAIP/terraform-modules.git//azurerm/resources/vnet/modules/azurerm_virtual_network?ref=master"
}

include {
path = find_in_parent_folders("azure.hcl")
}



dependency "resource-group" {
  config_path = "../../resource-group/hpaip-stg-common-rg1"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    name = "hpaip-stg-aigw-vnet1"
  }
}



inputs = {

  name = "hpaip-${local.environment_name}-aigw-vnet1"

  subscription_id = ${local.subscription_id}

  location = ${local.location}

  resource_group_name = ${dependency.resource_group.outputs.name}

  address_space = ["10.201.0.0/16"]

  tags = local.resource_tags

}
