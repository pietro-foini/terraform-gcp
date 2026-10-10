resource "random_password" "postgres_pwd" {
  length  = 16
  special = false
}

resource "google_secret_manager_secret" "postgres_user" {
  secret_id = "postgres_db_username"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "postgres_user" {
  secret      = google_secret_manager_secret.postgres_user.id
  secret_data = var.postgres_user
}

resource "google_secret_manager_secret" "postgres_pwd" {
  secret_id = "postgres_db_password"

  labels = {
    team = "ml"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "postgres_pwd" {
  secret      = google_secret_manager_secret.postgres_pwd.id
  secret_data = random_password.postgres_pwd.result
}