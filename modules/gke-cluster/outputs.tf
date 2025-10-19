output "cluster_name" {
  description = "Name of the created GKE cluster."
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "Endpoint of the GKE control plane."
  value       = google_container_cluster.primary.endpoint
}

output "cluster_master_version" {
  description = "Master version of the GKE cluster."
  value       = google_container_cluster.primary.master_version
}

output "node_pool_names" {
  description = "Names of the node pools created by the module."
  value       = keys(google_container_node_pool.pools)
}
