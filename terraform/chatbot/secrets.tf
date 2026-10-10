resource "google_secret_manager_secret" "auth_key" {
  secret_id = "auth_key"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}