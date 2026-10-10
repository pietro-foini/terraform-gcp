variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud Platform project"
}

variable "region" {
  type    = string
  description = "The region of the Google Cloud Platform project"
}

variable "branch_name" {
  description = "Git branch to monitor for the trigger"
  type        = string
}

variable "git_repository_link_id" {
  description = "Full resource ID of the Developer Connect Git Repository Link"
  type        = string
}

variable "cookie_secure" {
  description = "Cookie secure configuration flag or reference"
  type        = string
  default     = "false"
}

variable "llm_model" {
  description = "Identifier of the LLM model used by the chatbot"
  type        = string
  default     = "gemini-2.5-flash-lite"
}

variable "embeddings_model" {
  description = "Model identifier used for text embeddings"
  type        = string
  default     = "models/gemini-embedding-001"
}

variable "embeddings_size" {
  description = "Vector dimension size for the text embeddings"
  type        = number
  default     = 1024
}

variable "db_name" {
  description = "Database name for the chatbot service"
  type        = string
  default     = "chatbot"
}
