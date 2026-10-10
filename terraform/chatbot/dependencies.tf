data "google_service_account" "builder" {
  account_id = "app-builder"
  project    = var.project_id
}

data "google_sql_database_instance" "postgres" {
  name    = "postgres"
  project = var.project_id
}