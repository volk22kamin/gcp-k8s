# Development Cluster Stack

This stack provisions a GKE cluster in the development environment using the shared networking resources. It demonstrates how to consume the outputs of the networking stack and split workloads between public and private subnets via separate node pools.

## Usage

Initialise and review the plan from within this directory:

```bash
terraform init
terraform plan
```

The default configuration creates two node pools:

- `public`: Deploys nodes into the first subnet so they can use public egress.
- `private`: Deploys nodes into the second subnet for workloads that should remain private.

Toggle the `private_cluster_config` block in [`main.tf`](./main.tf) to switch the control plane and nodes to private-only networking when required.
