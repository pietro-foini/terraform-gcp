resource "google_cloudbuild_trigger" "trigger_ml_chatbot" {
  name        = "ml-chatbot"
  project     = var.project_id
  location    = var.region
  description = "Trigger for ML Chatbot server"


  developer_connect_event_config {
    git_repository_link = var.git_repository_link_id
    push {
      branch = var.branch_name
    }
  }

  substitutions = {
    _STORAGE_BUCKET : google_storage_bucket.chatbot_bucket.name
    _COOKIE_SECURE : var.cookie_secure
    _LLM_MODEL : var.llm_model
    _EMBEDDINGS_MODEL : var.embeddings_model
    _EMBEDDINGS_SIZE : var.embeddings_size
    _DB_NAME : var.db_name
  }

  service_account = data.google_service_account.builder.id
  filename        = "cloudbuild.yaml"
}



