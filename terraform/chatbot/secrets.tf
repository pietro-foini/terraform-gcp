resource "random_password" "auth_pwd" {
  length  = 64
  special = false
  upper   = false
  lower   = true
  numeric = true
}

resource "google_secret_manager_secret" "auth_key" {
  secret_id = "auth_key"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "postgres_pwd" {
  secret      = google_secret_manager_secret.auth_key.id
  secret_data = random_password.auth_pwd.result
}