terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    bucket = "tfstate-pipeline-dados"   # Substitua pelo nome do seu bucket de estado
    prefix = "terraform/state"
  }

}

provider "google" {
  project = local.project_id
  region  = var.region
}


module "infra" {
  source     = "./infra"
  project_id = "pipeline-dados-gcp"
  region     = "us-central1"
}
resource "google_storage_bucket" "function_source" {
  name     = "${var.project_id}-function-source"
  location = var.region
  force_destroy = true
}
locals {
  project_id = "pipeline-dados-gcp"
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function_source.zip"
  bucket = google_storage_bucket.function_source.name
  source = "${path.module}/../functions/process_json.zip"
}

resource "google_cloudfunctions_function" "process_json" {
  name        = "process-json"
  description = "Processa mensagens do Pub/Sub e salva no bucket"
  runtime     = "python310"
  region      = var.region
  source_archive_bucket = google_storage_bucket.function_source.name
  source_archive_object = google_storage_bucket_object.function_zip.name
  entry_point = "process_json"
  trigger_topic = google_pubsub_topic.data_topic.name
  available_memory_mb = 128
  environment_variables = {
    BUCKET_NAME = google_storage_bucket.data_bucket.name
  }
}
