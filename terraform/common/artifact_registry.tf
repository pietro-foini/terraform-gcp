resource "google_artifact_registry_repository" "ml_servers" {
  location      = var.region
  repository_id = "ml-servers"
  description   = "Docker package repository"
  format        = "DOCKER"

  labels = {
    team          = "ml"
  }

  vulnerability_scanning_config {
    enablement_config = "DISABLED"
  }
}