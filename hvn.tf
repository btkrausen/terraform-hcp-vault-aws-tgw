# Resources to define the HashiCorp Virtual Network (HVN)

resource "hcp_hvn" "primary" {
  hvn_id         = "primary-hvn"
  cloud_provider = "aws"
  region         = var.aws_cloud_region
  cidr_block     = var.hvn_cidr
}

# Assumes that a TGW exists in a centralized network (transit) account
data "aws_ec2_transit_gateway" "centralized_tgw" {
  id = var.tgw_id
}

# Assumes an existing VPC in a centralized network (transit) account
data "aws_vpc" "primary_vpc" {
  id = var.vpc_id
}

resource "aws_ram_resource_share" "tgw_share" {
  name                      = "hcp_vault_resource_share"
  allow_external_principals = true
}

resource "aws_ram_principal_association" "hcp_vault_principal" {
  resource_share_arn = aws_ram_resource_share.tgw_share.arn
  principal          = hcp_hvn.primary.provider_account_id
}

resource "aws_ram_resource_association" "hcp-vault" {
  resource_share_arn = aws_ram_resource_share.tgw_share.arn
  resource_arn       = data.aws_ec2_transit_gateway.centralized_tgw.arn
}

resource "hcp_aws_transit_gateway_attachment" "hcp-vault_tgw_attachement" {
  depends_on = [
    aws_ram_principal_association.hcp_vault_principal,
    aws_ram_resource_association.hcp-vault,
  ]

  hvn_id                        = hcp_hvn.primary.hvn_id
  transit_gateway_attachment_id = "hcp-vault-attachment"
  transit_gateway_id            = data.aws_ec2_transit_gateway.centralized_tgw.id
  resource_share_arn            = aws_ram_resource_share.tgw_share.arn
}

resource "hcp_hvn_route" "route" {
  hvn_link         = hcp_hvn.primary.self_link
  hvn_route_id     = "hcp-vault-to-tgw-route"
  destination_cidr = data.aws_vpc.primary_vpc.cidr_block
  target_link      = hcp_aws_transit_gateway_attachment.hcp-vault_tgw_attachement.self_link
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "hcp_vault_accepter" {
  transit_gateway_attachment_id = hcp_aws_transit_gateway_attachment.hcp-vault_tgw_attachement.provider_transit_gateway_attachment_id
}

# Create a route in the network account to properly route traffic bound to the HVN for Vault requests

resource "aws_route" "hcp_route" {
  route_table_id         = var.route_table_id
  destination_cidr_block = var.hvn_cidr
  gateway_id             = var.tgw_id
}