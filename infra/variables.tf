/* ===============================
   ARQUIVO: variables.tf
   =============================== */
variable "project_id" {
  description = "ID do projeto GCP"
  type        = string  
}

variable "region" {
  description = "Região padrão do projeto"
  type        = string
  default     = "us-central1"
}