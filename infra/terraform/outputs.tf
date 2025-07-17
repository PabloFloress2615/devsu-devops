output "cluster_name" {
  description = "Nombre del clúster GKE"
  value       = google_container_cluster.standard.name
}

output "cluster_endpoint" {
  description = "Endpoint maestro (API server) del clúster"
  value       = google_container_cluster.standard.endpoint
}

output "cluster_ca_certificate" {
  description = "Certificado CA (base64) para el kubeconfig"
  value       = google_container_cluster.standard.master_auth[0].cluster_ca_certificate
}

output "node_pool_name" {
  description = "Nombre del pool de nodos"
  value       = google_container_node_pool.primary.name
}