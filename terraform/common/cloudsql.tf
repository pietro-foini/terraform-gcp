resource "google_sql_database_instance" "postgres" {
  name             = "postgres"
  database_version = "POSTGRES_18"
  region           = var.region

  deletion_protection = false

  settings {
    tier      = "db-g1-small"
    edition   = "ENTERPRISE"
    disk_size = 10
    disk_type = "PD_SSD"

    ip_configuration {
      ipv4_enabled = true
    }
  }
}

resource "google_sql_user" "chatbot_user" {
  name     = google_secret_manager_secret_version.postgres_user.secret_data
  instance = google_sql_database_instance.postgres.name
  password = google_secret_manager_secret_version.postgres_pwd.secret_data
}
