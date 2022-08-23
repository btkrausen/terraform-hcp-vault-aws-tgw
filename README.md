<img alt="vault" src="https://img.shields.io/badge/Vault-FFD814?style=for-the-badge&logo=Vault&logoColor=black" width="80" height="30" />

# hcp-vault-aws-tgw-module

This module is designed to provision a HashiCorp Virtual Network as well as a new HCP Vault cluster. Connectivity from the HCP environment is done using a Transit Gateway.

Since most organizations already have an established network strategy, or the network stack is defined in another Terraform configuration, this module assumes the following:
* The VPC in the targeted account (Network account) already exists
* The Transit Gateway in the targeted account (Network account) already exists
* A private route table exists for the VPC in the targeted account

An [example .tfvars file](https://github.com/btkrausen/hcp_vault_aws_tgw/blob/main/examples/terraform.tfvars.example) is included to configure values of required variables.

<br>

<img alt="vault" src="https://github.com/btkrausen/terraform-hcp-vault-aws-tgw/blob/main/images/hcp_vault_tgw.png" />

 ***

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | 0.41.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.41.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment_accepter.hcp_vault_accepter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment_accepter) | resource |
| [aws_ram_principal_association.hcp_vault_principal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.hcp-vault](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.tgw_share](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route.hcp_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [hcp_aws_transit_gateway_attachment.hcp-vault_tgw_attachement](https://registry.terraform.io/providers/hashicorp/hcp/0.41.0/docs/resources/aws_transit_gateway_attachment) | resource |
| [hcp_hvn.primary](https://registry.terraform.io/providers/hashicorp/hcp/0.41.0/docs/resources/hvn) | resource |
| [hcp_hvn_route.route](https://registry.terraform.io/providers/hashicorp/hcp/0.41.0/docs/resources/hvn_route) | resource |
| [hcp_vault_cluster.hcp-cluster](https://registry.terraform.io/providers/hashicorp/hcp/0.41.0/docs/resources/vault_cluster) | resource |
| [aws_ec2_transit_gateway.centralized_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway) | data source |
| [aws_vpc.primary_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_cloud_region"></a> [aws\_cloud\_region](#input\_aws\_cloud\_region) | AWS Cloud Region that HCP Vault will be connected to | `string` | `"us-east-1"` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | Client ID for HCP Organization | `string` | n/a | yes |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | Client Secret for HCP Organization | `string` | n/a | yes |
| <a name="input_cluster_id"></a> [cluster\_id](#input\_cluster\_id) | The ID of the Vault cluster | `string` | `"primary-vault-cluster"` | no |
| <a name="input_hvn_cidr"></a> [hvn\_cidr](#input\_hvn\_cidr) | The CIDR block for HashiCorp Virtual Network | `string` | `"172.31.0.0/16"` | no |
| <a name="input_hvn_id"></a> [hvn\_id](#input\_hvn\_id) | Name/ID of the HVN Network - displays in the UI | `string` | n/a | yes |
| <a name="input_public_vault"></a> [public\_vault](#input\_public\_vault) | Should this Vault cluster have a public endpoint? | `bool` | `false` | no |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | The private route table in the network/transit account to route data to the HVN for Vault requests | `string` | n/a | yes |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | The ID of the existing TGW in your AWS network/transit account | `string` | n/a | yes |
| <a name="input_vault_tier"></a> [vault\_tier](#input\_vault\_tier) | Tier of the HCP Vault cluster. Valid options for tiers - dev, starter\_small, standard\_small, standard\_medium, standard\_large, plus\_small, plus\_medium, plus\_large | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID of an existing VPC in the Network (Transit) account | `string` | n/a | yes |

## Outputs

No outputs.