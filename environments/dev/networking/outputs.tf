# Outputs for the networking stack

output "vpc_name" {
  description = "The VPC network name"
  value       = module.networking.network_name
}

output "subnet_names" {
  description = "The names of the subnets"
  value       = module.networking.subnet_names
}

output "subnet_self_links" {
  description = "The self-links of the subnets"
  value       = module.networking.subnet_self_links
}

output "network_self_link" {
  description = "The self-link of the VPC network"
  value       = module.networking.network_self_link
}
