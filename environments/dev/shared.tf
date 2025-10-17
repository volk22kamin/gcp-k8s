# environments/dev/shared.tf

locals {
  # From region.tf
  region        = "europe-west3"
  zone_a_suffix = "-a"
  zone_b_suffix = "-b"
  zone_a        = "${local.region}${local.zone_a_suffix}"
  zone_b        = "${local.region}${local.zone_b_suffix}"

  # From locals.tf
  naming_prefix = "k8s-project"
  base_labels = {
    project    = "k8s-project"
    managed_by = "terraform"
    repo       = "k8s-gcp-training"
  }
  required_apis = [
    "compute.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "run.googleapis.com",
    "storage.googleapis.com",
    "cloudbuild.googleapis.com",
    "secretmanager.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com"
  ]
 
  # From component main.tf files
  environment = "dev"

  # Centralized from components
  project_id = "training-472512"
  common_labels = merge(
    local.base_labels,
    {
      environment = local.environment
      team        = "platform"
    }
  )
}
