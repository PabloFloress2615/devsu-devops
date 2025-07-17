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
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    machine_type   = "e2-small"
    disk_type      = "pd-balanced"
    disk_size_gb   = 100
    image_type     = "COS_CONTAINERD"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}