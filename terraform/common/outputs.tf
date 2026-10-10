output "db_instance_name" {
  description = "The name of the Cloud SQL database instance"
  value       = google_sql_database_instance.postgres.name
}

output "db_connection_name" {
  description = "The connection name of the Cloud SQL instance (format: project:region:instance)"
  value       = google_sql_database_instance.postgres.connection_name
}