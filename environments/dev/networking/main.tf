# Networking Stack Configuration



## Networking module
module "networking" {
  source = "../../../modules/networking"

  project_id     = local.project_id
  region         = local.region
  network_name   = "${local.naming_prefix}-vpc-${local.environment}"
  subnets = [
    {
      name          = "${local.naming_prefix}-subnet-${local.environment}-a"
      ip_cidr_range = "10.10.1.0/24"
      zone          = local.zone_a
    },
    {
      name          = "${local.naming_prefix}-subnet-${local.environment}-b"
      ip_cidr_range = "10.10.2.0/24"
      zone          = local.zone_b
    }
  ]
  firewall_rules = local.dev_firewall_rules
}

# Enable required GCP APIs
resource "google_project_service" "apis" {
  for_each = toset(local.required_apis)
  project  = local.project_id
  service  = each.key

  # Keep the API enabled even when you destroy the stack
  disable_on_destroy = false
}

resource "google_compute_project_metadata_item" "os_login" {
  project = local.project_id
  key     = "enable-oslogin"
  value   = "TRUE"
}
