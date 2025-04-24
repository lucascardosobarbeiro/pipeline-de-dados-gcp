resource "google_storage_bucket" "function_source" {
  name = "${var.project_id}-function-source"
  location = var.region
  force_destroy = true
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function_source.zip"
  bucket = google_storage_bucket.function_source.name
  source = "${path.module}/../functions/process_json.zip"
}

resource "google_cloudfunctions_function" "process_json" {
  name        = "process-json"
  project     = var.project_id
  description = "Processa mensagens do Pub/Sub e salva no bucket"
  runtime     = "python310"
  region      = var.region
  source_archive_bucket = google_storage_bucket.function_source.name
  source_archive_object = google_storage_bucket_object.function_zip.name
  entry_point = "process_json"
  available_memory_mb   = 128

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.data_topic.id
  }

  environment_variables = {
    BUCKET_NAME = google_storage_bucket.data_bucket.name
  }
}
