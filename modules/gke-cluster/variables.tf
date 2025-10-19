variable "project_id" {
  description = "The ID of the project where the cluster will be created."
  type        = string
}

variable "location" {
  description = "The region or zone where the cluster will be deployed."
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster."
  type        = string
}

variable "network" {
  description = "Self link of the VPC network that hosts the cluster."
  type        = string
}

variable "subnetwork" {
  description = "Self link of the default subnetwork for the control plane and node pools."
  type        = string
}

variable "release_channel" {
  description = "Release channel to subscribe the cluster to. Set to null to disable."
  type        = string
  default     = "REGULAR"
}

variable "cluster_resource_labels" {
  description = "Resource labels applied to the cluster."
  type        = map(string)
  default     = {}
}

variable "authorized_networks" {
  description = "Authorized networks for master access."
  type = list(object({
    name        = string
    cidr_block  = string
    description = optional(string)
  }))
  default = []
}

variable "private_cluster_config" {
  description = "Configuration for enabling a private control plane."
  type = object({
    enable_private_nodes    = bool
    enable_private_endpoint = optional(bool, false)
    master_ipv4_cidr_block  = optional(string)
    master_global_access    = optional(bool, false)
  })
  default = {
    enable_private_nodes = false
  }
}

variable "ip_allocation_policy" {
  description = "Configuration for VPC native clusters."
  type = object({
    cluster_secondary_range_name  = optional(string)
    services_secondary_range_name = optional(string)
  })
  default = null
}

variable "default_oauth_scopes" {
  description = "Default OAuth scopes to attach to node pools when none are provided."
  type        = list(string)
  default     = [
    "https://www.googleapis.com/auth/cloud-platform"
  ]
}

variable "default_service_account" {
  description = "Default service account to use for node pools when none is provided."
  type        = string
  default     = null
}

variable "default_disk_size_gb" {
  description = "Default boot disk size for node pools."
  type        = number
  default     = 100
}

variable "default_disk_type" {
  description = "Default boot disk type for node pools."
  type        = string
  default     = "pd-balanced"
}

variable "default_preemptible" {
  description = "Whether node pools are preemptible by default."
  type        = bool
  default     = false
}

variable "default_metadata" {
  description = "Default metadata to attach to node pool instances."
  type        = map(string)
  default     = {
    "disable-legacy-endpoints" = "true"
  }
}

variable "default_labels" {
  description = "Default labels for node pool instances."
  type        = map(string)
  default     = {}
}

variable "default_tags" {
  description = "Default network tags for node pool instances."
  type        = list(string)
  default     = []
}

variable "default_auto_upgrade" {
  description = "Whether node pools auto-upgrade by default."
  type        = bool
  default     = true
}

variable "default_auto_repair" {
  description = "Whether node pools auto-repair by default."
  type        = bool
  default     = true
}

variable "node_pools" {
  description = "Map of node pool definitions to create."
  type = map(object({
    machine_type       = string
    min_count          = number
    max_count          = number
    initial_node_count = optional(number)
    disk_size_gb       = optional(number)
    disk_type          = optional(string)
    preemptible        = optional(bool)
    service_account    = optional(string)
    labels             = optional(map(string))
    tags               = optional(list(string))
    metadata           = optional(map(string))
    oauth_scopes       = optional(list(string))
    node_locations     = optional(list(string))
    auto_upgrade       = optional(bool)
    auto_repair        = optional(bool)
    subnetwork         = optional(string)
  }))
  default = {}
}
