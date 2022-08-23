###################################################
# HCP Organizational Permissions and Configurations
###################################################

variable "client_id" {
  description = "Client ID for HCP Organization"
  type        = string
}

variable "client_secret" {
  description = "Client Secret for HCP Organization"
  type        = string
}

###################################################
# HashiCorp Virtual Network Configurations
###################################################

variable "aws_cloud_region" {
  description = "AWS Cloud Region that HCP Vault will be connected to"
  type        = string
  default     = "us-east-1"
}

variable "hvn_id" {
  description = "Name/ID of the HVN Network - displays in the UI"
  type        = string
}

variable "hvn_cidr" {
  description = "The CIDR block for HashiCorp Virtual Network"
  type        = string
  default     = "172.31.0.0/16"
}

variable "vpc_id" {
  description = "VPC ID of an existing VPC in the Network (Transit) account"
  type        = string
}

variable "tgw_id" {
  description = "The ID of the existing TGW in your AWS network/transit account"
  type        = string
}

variable "route_table_id" {
  description = "The private route table in the network/transit account to route data to the HVN for Vault requests"
  type        = string
}
###################################################
# Vault Cluster configurations
###################################################

variable "cluster_id" {
  description = "The ID of the Vault cluster"
  type        = string
  default     = "primary-vault-cluster"
}

variable "public_vault" {
  description = "Should this Vault cluster have a public endpoint?"
  type        = bool
  default     = false
}

variable "vault_tier" {
  description = "Tier of the HCP Vault cluster. Valid options for tiers - dev, starter_small, standard_small, standard_medium, standard_large, plus_small, plus_medium, plus_large"
  type        = string
  validation {
    condition     = contains(["dev", "starter_small", "standard_small", "standard_medium", "standard_large", "plus_small", "plus_medium", "plus_large"], var.vault_tier)
    error_message = "Valid options for cluster tier - dev, starter_small, standard_small, standard_medium, standard_large, plus_small, plus_medium, plus_large"
  }
}