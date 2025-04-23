variable "project_id" {
  type        = string
  default     = "pipeline-dados-gcp" # Substitua pelo ID do seu projeto GCP
  description = "ID do projeto GCP"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Região padrão dos recursos"
}
