variable "namespace" {
  type        = string
  description = "Name prefix used for resources"
}

variable "domain_name" {
  type        = string
  description = "Domain name used to access instance."
}

variable "subdomain" {
  type        = string
  default     = null
  description = "Subdomain for accessing the Weights & Biases UI."
}

variable "create_certificate" {
  description = "Whether to create ACM certificate"
  type        = bool
  default     = true
}

variable "validate_certificate" {
  description = "Whether to validate certificate by creating Route53 record"
  type        = bool
  default     = true
}
variable "engine_version" {
  description = "The database engine version. Updating this argument results in an outage"
  type        = string
  default     = "8.0.mysql_aurora.3.07.1"
}

variable "license" {
  type = string
}

variable "zone_id" {
  type        = string
  description = "Domain for creating the Weights & Biases subdomain on."
}

variable "allowed_inbound_cidr" {
 description = "CIDRs allowed to access wandb-server."
 nullable    = false
 type        = list(string)
}

variable "allowed_inbound_ipv6_cidr" {
 description = "CIDRs allowed to access wandb-server."
 nullable    = false
 type        = list(string)
}