resource "google_storage_bucket" "chatbot_bucket" {
  name                        = "${var.project_id}-chatbot"
  location                    = var.region
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  force_destroy               = true
}

