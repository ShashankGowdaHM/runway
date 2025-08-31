locals {
  environment        = "stg"
  alternate_env_name = "stg"
  env_tag            = "stg"
  environment_tags = {
    "Environment" = local.environment
  }
}