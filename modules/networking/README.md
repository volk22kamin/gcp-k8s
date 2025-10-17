# Networking Module

This Terraform module creates a Virtual Private Cloud (VPC) network on Google Cloud Platform (GCP).

## Features

- Creates a VPC network.
- Creates a configurable number of subnets within the VPC.
- Enables Private Google Access for the subnets.
- Optionally creates a Cloud NAT gateway for outbound internet access from private instances.
- Provides a flexible way to define firewall rules.

## Usage

```hcl
module "networking" {
  source = "../../modules/networking"

  project_id   = "your-gcp-project-id"
  network_name = "my-vpc"
  region       = "eu-central-1"

  subnets = [
    {
      name          = "subnet-prod-a"
      ip_cidr_range = "10.10.1.0/24"
      zone          = "eu-central-1-a"
    },
    {
      name          = "subnet-prod-b"
      ip_cidr_range = "10.10.2.0/24"
      zone          = "eu-central-1-b"
    }
  ]

  enable_cloud_nat = true

  firewall_rules = [
    {
      name          = "allow-ssh"
      description   = "Allow SSH from a specific IP range"
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["your.ip.address.here/32"]
      target_tags   = []
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
    },
    {
      name          = "allow-web-traffic"
      description   = "Allow HTTP and HTTPS traffic to web servers"
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["0.0.0.0/0"]
      target_tags   = ["web-server"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["80", "443"]
        }
      ]
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | The GCP project ID | `string` | n/a | yes |
| network\_name | The name of the VPC network | `string` | `"todo-vpc"` | no |
| region | The GCP region | `string` | `"eu-central-1"` | no |
| subnets | A list of subnets to create | <pre>list(object({
    name    = string
    ip_cidr_range = string
    zone    = string
  }))</pre> | see `variables.tf` | no |
| enable\_cloud\_nat | Enable Cloud NAT for the VPC | `bool` | `false` | no |
| firewall\_rules | A list of firewall rules to create | <pre>list(object({
    name          = string
    description   = string
    direction     = string
    priority      = number
    source_ranges = list(string)
    target_tags   = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))</pre> | see `variables.tf` | no |

## Outputs

| Name | Description |
|------|-------------|
| network\_name | The name of the VPC network |
| network\_self\_link | The self-link of the VPC network |
| subnet\_names | The names of the subnets |
| subnet\_self\_links | The self-links of the subnets |