variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
}

variable "name" {
  description = "The name of the Cognitive Services Account Deployment"
  type        = string
}

variable "cognitive_account_id" {
  description = "The ID of the Cognitive Services Account"
  type        = string
}

variable "model_format" {
  description = "The format of the Cognitive Services Account Deployment model"
  type        = string
}

variable "model_name" {
  description = "The name of the Cognitive Services Account Deployment model"
  type        = string
}

variable "model_version" {
  description = "The version of the Cognitive Services Account Deployment model"
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The name of the SKU"
  type        = string
}

variable "rai_policy_name" {
  description = "The name of RAI policy"
  type        = string
  default     = null
}

variable "version_upgrade_option" {
  description = "Deployment model version upgrade option"
  type        = string
  default     = "OnceNewDefaultVersionAvailable"
}

variable "sku_tier" {
  description = "The tier of the SKU"
  type        = string
  default     = null
}

variable "sku_size" {
  description = "The SKU size"
  type        = string
  default     = null
}

variable "sku_family" {
  description = "The family of the SKU"
  type        = string
  default     = null
}

variable "sku_capacity" {
  description = "Tokens-per-Minute (TPM) capacity"
  type        = number
  default     = 1
}