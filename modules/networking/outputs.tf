output "network_name" {
  description = "The name of the VPC network"
  value       = google_compute_network.vpc.name
}

output "network_self_link" {
  description = "The self-link of the VPC network"
  value       = google_compute_network.vpc.self_link
}

output "subnet_names" {
  description = "The names of the subnets"
  value       = [for s in google_compute_subnetwork.subnets : s.name]
}

output "subnet_self_links" {
  description = "The self-links of the subnets"
  value       = { for s in google_compute_subnetwork.subnets : s.name => s.self_link }
}