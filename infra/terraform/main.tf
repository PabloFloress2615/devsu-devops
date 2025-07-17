resource "google_container_cluster" "standard" {
  name                     = "gke-standard-cluster"
  location                 = var.zone
  remove_default_node_pool = true

  initial_node_count       = 1
}

resource "google_container_node_pool" "primary" {
  name     = "standard-pool"
  cluster  = google_container_cluster.standard.name
  location = var.zone

  autoscaling {
    min_node_count = 0
    max_node_count = 1
  }

  node_config {
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}