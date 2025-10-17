variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "todo-vpc"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "eu-central-1"
}

variable "subnets" {
  description = "A list of subnets to create"
  type = list(object({
    name    = string
    ip_cidr_range = string
    zone    = string
  }))
  default = [
    {
      name          = "subnet-a"
      ip_cidr_range = "10.0.1.0/24"
      zone          = "eu-central-1-a"
    },
    {
      name          = "subnet-b"
      ip_cidr_range = "10.0.2.0/24"
      zone          = "eu-central-1-b"
    }
  ]
}

variable "enable_cloud_nat" {
  description = "Enable Cloud NAT for the VPC"
  type        = bool
  default     = false
}

variable "firewall_rules" {
  description = "A list of firewall rules to create"
  type = list(object({
    name               = string
    description        = string
    direction          = string
    priority           = number
    source_ranges      = optional(list(string))
    source_tags        = optional(list(string))
    destination_ranges = optional(list(string))
    target_tags        = optional(list(string))
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
  default = [
    {
      name          = "allow-ssh"
      description   = "Allow SSH from anywhere"
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["0.0.0.0/0"]
      target_tags   = []
      allow = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
    },
    {
      name          = "allow-internal"
      description   = "Allow internal traffic"
      direction     = "INGRESS"
      priority      = 1000
      source_ranges = ["10.0.0.0/8"]
      target_tags   = []
      allow = [
        {
          protocol = "all"
          ports    = []
        }
      ]
    }
  ]
}