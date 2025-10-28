# Cluster Stack Configuration

data "terraform_remote_state" "networking" {
  backend = "local"

  config = {
    path = "../networking/terraform.tfstate"
  }
}

locals {
  cluster_name     = "${local.naming_prefix}-gke-${local.environment}"
  subnet_self_links = data.terraform_remote_state.networking.outputs.subnet_self_links
}

module "cluster" {
  source = "../../../modules/gke-cluster"

  project_id   = local.project_id
  location     = local.region
  cluster_name = local.cluster_name
  network      = data.terraform_remote_state.networking.outputs.network_self_link
  subnetwork   = local.subnet_self_links["${local.naming_prefix}-subnet-${local.environment}-a"]

  cluster_resource_labels = local.common_labels

  deletion_protection = false

  private_cluster_config = {
    enable_private_nodes    = false
    enable_private_endpoint = false
  }

  node_pools = {
    public = {
      machine_type   = "e2-standard-4"
      min_count      = 1
      max_count      = 3
      node_locations = [local.zone_a]
      subnetwork     = local.subnet_self_links["${local.naming_prefix}-subnet-${local.environment}-a"]
      labels = {
        visibility = "public"
      }
    }

    private = {
      machine_type   = "e2-standard-4"
      min_count      = 1
      max_count      = 2
      node_locations = [local.zone_b]
      subnetwork     = local.subnet_self_links["${local.naming_prefix}-subnet-${local.environment}-b"]
      labels = {
        visibility = "private"
      }
    }
  }
}
