resource "hcp_vault_cluster" "hcp-cluster" {
  cluster_id      = var.cluster_id
  hvn_id          = hcp_hvn.primary.hvn_id
  tier            = var.vault_tier
  public_endpoint = var.public_vault

#   metrics_config {
#     datadog_api_key = "test_datadog"
#     datadog_region  = "us1"
#   }
#   audit_log_config {
#     datadog_api_key = "test_datadog"
#     datadog_region  = "us1"
#   }
  
  lifecycle {
    prevent_destroy = true
  }
}