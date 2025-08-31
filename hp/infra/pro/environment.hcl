locals {
  environment        = "pro"
  alternate_env_name = "pro"
  env_tag            = "pro"
  environment_tags = {
    "Environment" = local.environment
  }
}