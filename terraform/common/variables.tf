variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud Platform project"
}

variable "region" {
  type    = string
  description = "The region of the Google Cloud Platform project"
}

variable "postgres_user" {
  type    = string
  description = "The name of the user for PostgreSQL database"
}