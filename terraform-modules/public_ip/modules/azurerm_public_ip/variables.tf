variable "name" {
  description = "Specifies the name of the Public IP. Changing this forces a new Public IP to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where this Public IP should exist. Changing this forces a new Public IP to be created."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the Public IP should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  type        = string
}

variable "zones" {
  description = "A collection containing the availability zone to allocate the Public IP in. Changing this forces a new resource to be created."
  type        = list(string)
  default     = []
}

variable "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited."
  type        = string
  default     = "VirtualNetworkInherited"
}

variable "ddos_protection_plan_id" {
  description = "The ID of DDoS protection plan associated with the public IP. Can only be set when ddos_protection_mode is Enabled."
  type        = string
  default     = null
}

variable "domain_name_label" {
  description = "Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  type        = string
  default     = null
}

variable "domain_name_label_scope" {
  description = "Scope for the domain name label. Possible values are NoReuse, ResourceGroupReuse, SubscriptionReuse and TenantReuse. Changing this forces a new Public IP to be created."
  type        = string
  default     = null
}

variable "edge_zone" {
  description = "Specifies the Edge Zone within the Azure Region where this Public IP should exist. Changing this forces a new Public IP to be created."
  type        = string
  default     = null
}

variable "idle_timeout_in_minutes" {
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = 4
}

variable "ip_tags" {
  description = "A mapping of IP tags to assign to the public IP. Changing this forces a new resource to be created."
  type        = map(string)
  default     = {}
}

variable "ip_version" {
  description = "The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created. Defaults to IPv4."
  type        = string
  default     = "IPv4"
}

variable "public_ip_prefix_id" {
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "reverse_fqdn" {
  description = "A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  type        = string
  default     = null
}

variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Standard. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}

variable "sku_tier" {
  description = "The SKU Tier that should be used for the Public IP. Possible values are Regional and Global. Defaults to Regional. Changing this forces a new resource to be created."
  type        = string
  default     = "Regional"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "create_timeout" {
  description = "Timeout for creating the Public IP"
  type        = string
  default     = "30m"
}

variable "update_timeout" {
  description = "Timeout for updating the Public IP"
  type        = string
  default     = "30m"
}

variable "read_timeout" {
  description = "Timeout for reading the Public IP"
  type        = string
  default     = "5m"
}

variable "delete_timeout" {
  description = "Timeout for deleting the Public IP"
  type        = string
  default     = "30m"
}

variable "subscription_id" {
  description = "Subscription id where the public ip is created"
  type        = string
}