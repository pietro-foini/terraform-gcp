resource "google_secret_manager_secret" "flask-secret" {
  secret_id = "postgres_db_username"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "atlassian-secret" {
  secret_id = "postgres_db_password"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret" "mapbox-secret" {
  secret_id = "secret_key"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}