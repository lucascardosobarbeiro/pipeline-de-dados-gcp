resource "google_storage_bucket" "data_bucket" {
  name     = "${var.project_id}-data-bucket"
  location = var.region
}

resource "google_pubsub_topic" "json_topic" {
  name = "json-upload-topic"
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "json_data"
  location   = var.region
}

resource "google_bigquery_table" "table" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "items"
  schema     = jsonencode([
    {
      name = "id"
      type = "STRING"
    },
    {
      name = "value"
      type = "STRING"
    }
  ])
}

resource "google_storage_notification" "bucket_notification" {
  bucket         = google_storage_bucket.data_bucket.name
  payload_format = "JSON_API_V1"
  topic          = google_pubsub_topic.json_topic.id
  event_types    = ["OBJECT_FINALIZE"]
}

resource "google_cloudfunctions_function" "process_json" {
  name        = "process-json"
  runtime     = "nodejs18"
  region      = var.region
  source_archive_bucket = google_storage_bucket.data_bucket.name
  source_archive_object = "function-source.zip"
  entry_point = "processJson"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.json_topic.id
  }

  environment_variables = {
    BQ_DATASET = google_bigquery_dataset.dataset.dataset_id
    BQ_TABLE   = google_bigquery_table.table.table_id
  }
}
