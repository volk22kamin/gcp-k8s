# Outputs for the cluster stack

output "cluster_name" {
  description = "Name of the provisioned GKE cluster"
  value       = module.cluster.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for the cluster control plane"
  value       = module.cluster.cluster_endpoint
}

output "node_pool_names" {
  description = "Node pools created for the cluster"
  value       = module.cluster.node_pool_names
}
