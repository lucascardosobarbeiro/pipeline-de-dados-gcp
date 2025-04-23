resource "google_storage_bucket" "processed_bucket" {
  name     = "meu-bucket-processado"
  location = "US"
  force_destroy = true
}

resource "google_pubsub_topic" "data_topic" {
  name = "data-topic"
}

resource "google_cloudfunctions_function" "process_json" {
  name        = "process-json-fn"
  description = "Função que processa JSON de mensagens do Pub/Sub e salva no GCS"
  runtime     = "python311"
  region      = var.region

  # Código da função
  source_directory = "${path.module}/../functions/process_json"
  entry_point      = "process_pubsub"
  trigger_topic    = google_pubsub_topic.data_topic.name

  # Variáveis de ambiente
  available_memory_mb   = 256
  service_account_email = google_service_account.functions.email

  environment_variables = {
    BUCKET_NAME = google_storage_bucket.processed_bucket.name
  }
}

resource "google_service_account" "functions" {
  account_id   = "cloud-function-sa"
  display_name = "Service Account for Cloud Function"
}

resource "google_project_iam_member" "function_storage_access" {
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.functions.email}"
}

resource "google_project_iam_member" "function_pubsub_access" {
  role   = "roles/pubsub.subscriber"
  member = "serviceAccount:${google_service_account.functions.email}"
}
