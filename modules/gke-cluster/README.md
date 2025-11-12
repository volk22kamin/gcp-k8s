# GKE Cluster Module

This Terraform module provisions a configurable Google Kubernetes Engine (GKE) cluster and a set of managed node pools. It is designed to work with the networking resources exposed by the `modules/networking` stack in this repository but can also be reused in other environments.

## Features

- Creates a regional or zonal cluster inside an existing VPC network and subnetwork
- Supports private control planes with optional public endpoint access
- Manages multiple node pools with independent sizing, metadata, and subnet selection so you can split workloads between public and private subnets
- Provides sane defaults for OAuth scopes, disk configuration, and upgrade/repair policies while still being fully overridable

## Usage

```hcl
module "gke_cluster" {
  source = "../../modules/gke-cluster"

  project_id   = local.project_id
  location     = local.region
  cluster_name = "example-gke"
  network      = data.terraform_remote_state.networking.outputs.network_self_link
  subnetwork   = data.terraform_remote_state.networking.outputs.subnet_self_links["public"]

  node_pools = {
    public = {
      machine_type = "e2-medium"
      min_count    = 1
      max_count    = 3
      subnetwork   = data.terraform_remote_state.networking.outputs.subnet_self_links["public"]
    }
    private = {
      machine_type = "e2-standard-4"
      min_count    = 1
      max_count    = 2
      subnetwork   = data.terraform_remote_state.networking.outputs.subnet_self_links["private"]
    }
  }

  private_cluster_config = {
    enable_private_nodes = false
  }
}
```

Refer to [`variables.tf`](./variables.tf) for the complete list of inputs and to [`outputs.tf`](./outputs.tf) for the available outputs.
