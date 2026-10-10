module "service_accounts" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "5.1.0"
  project_id    = var.project_id
  prefix     = "app"
  names      = ["builder"]

  project_roles = [
    "${var.project_id}=>roles/aiplatform.user",
    "${var.project_id}=>roles/artifactregistry.writer",
    "${var.project_id}=>roles/cloudbuild.builds.builder",
    "${var.project_id}=>roles/run.admin",
    "${var.project_id}=>roles/cloudsql.client",
    "${var.project_id}=>roles/developerconnect.readTokenAccessor",
    "${var.project_id}=>roles/logging.logWriter",
    "${var.project_id}=>roles/secretmanager.secretAccessor",
    "${var.project_id}=>roles/iam.serviceAccountUser",
    "${var.project_id}=>roles/storage.objectUser",
  ]
}
