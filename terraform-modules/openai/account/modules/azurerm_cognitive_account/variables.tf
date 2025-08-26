variable "account_name" {
  description = "The name of the Cognitive Account"
  type        = string
}

variable "location" {
  description = "The location of the Cognitive Account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Cognitive Account"
  type        = string
}

variable "kind" {
  description = "The kind of the Cognitive Account"
  type        = string
  default     = "OpenAI"
}

variable "custom_subdomain_name" {
  description = "The custom subdomain name of the Cognitive Account"
  type        = string
  default     = ""
}

variable "sku_name" {
  description = "The SKU name of the Cognitive Account"
  type        = string
  default     = "S0"
}

variable "subscription_id" {
  description = "Subscription id where the openai deployment is created"
  type        = string
}

variable "dynamic_throttling_enabled" {
  description = "Whether to enable the dynamic throttling for this Cognitive Service Account"
  type        = bool
  default     = false
}

variable "local_auth_enabled" {
  description = "Whether local authentication methods are enabled for the Cognitive Account"
  type        = bool
  default     = true
}

variable "outbound_network_access_restricted" {
  description = "Whether outbound network access is restricted for the Cognitive Account"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for the Cognitive Account"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "customer_managed_key" {
  description = "A customer_managed_key block"
  type = object({
    key_vault_key_id   = string
    identity_client_id = optional(string)
  })
  default = null
}

variable "network_acls" {
  description = "A network_acls block"
  type = object({
    default_action = string
    ip_rules       = optional(list(string))
    virtual_network_rules = optional(list(object({
      subnet_id                            = string
      ignore_missing_vnet_service_endpoint = optional(bool, false)
    })), [])
  })
  default = null
}

variable "identity" {
  description = "An identity block"
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "storage" {
  description = "A storage block"
  type = object({
    storage_account_id = string
    identity_client_id = optional(string)
  })
  default = null
}

variable "metrics_advisor_aad_client_id" {
  description = "The Azure AD Client ID (Application ID) for Metrics Advisor"
  type        = string
  default     = ""
}

variable "metrics_advisor_aad_tenant_id" {
  description = "The Azure AD Tenant ID for Metrics Advisor"
  type        = string
  default     = ""
}

variable "metrics_advisor_super_user_name" {
  description = "The super user of Metrics Advisor"
  type        = string
  default     = ""
}

variable "metrics_advisor_website_name" {
  description = "The website name of Metrics Advisor"
  type        = string
  default     = ""
}

variable "qna_runtime_endpoint" {
  description = "A URL to link a QnAMaker cognitive account to a QnA runtime"
  type        = string
  default     = ""
}

variable "custom_question_answering_search_service_id" {
  description = "If kind is TextAnalytics this specifies the ID of the Search service"
  type        = string
  default     = ""
}

variable "custom_question_answering_search_service_key" {
  description = "If kind is TextAnalytics this specifies the key of the Search service"
  type        = string
  default     = ""
}