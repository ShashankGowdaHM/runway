output "cognitive_account_id" {
  description = "The ID of the Cognitive Account"
  value       = azurerm_cognitive_account.model_account.id
}

output "cognitive_account_name" {
  description = "The name of the Cognitive Account"
  value       = azurerm_cognitive_account.model_account.name
}

output "cognitive_account_kind" {
  description = "The kind of the Cognitive Account"
  value       = azurerm_cognitive_account.model_account.kind
}