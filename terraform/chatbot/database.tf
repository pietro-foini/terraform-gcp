resource "google_sql_database" "chatbot_db" {
  name     = var.db_name
  instance = data.google_sql_database_instance.postgres.name
  project  = var.project_id
}
