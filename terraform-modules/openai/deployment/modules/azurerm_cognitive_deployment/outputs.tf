output "cognitive_deployment_id" {
  description = "The ID of the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.id
}

output "cognitive_deployment_name" {
  description = "The name of the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.name
}

output "cognitive_deployment_model_format" {
  description = "The format of the model used in the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.model[0].format
}

output "cognitive_deployment_model_name" {
  description = "The name of the model used in the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.model[0].name
}

output "cognitive_deployment_model_version" {
  description = "The version of the model used in the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.model[0].version
}

output "cognitive_deployment_sku_name" {
  description = "The SKU name of the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.sku[0].name
}

output "cognitive_deployment_rai_policy_name" {
  description = "The name of the RAI policy"
  value       = azurerm_cognitive_deployment.model_deployment.rai_policy_name
}

output "cognitive_deployment_version_upgrade_option" {
  description = "The version upgrade option for the Cognitive Deployment"
  value       = azurerm_cognitive_deployment.model_deployment.version_upgrade_option
}