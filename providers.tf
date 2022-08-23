terraform {
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.41.0"
    }
  }
}

provider "hcp" {
  client_id     = var.client_id
  client_secret = var.client_secret
}

# Assumes AWS credentials will be set via environment variables

provider "aws" {
  region = var.aws_cloud_region
}