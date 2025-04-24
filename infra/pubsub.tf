/* ===============================
   ARQUIVO: pubsub.tf
   =============================== */
resource "google_pubsub_topic" "data_topic" {
  name    = "data-topic"
  project = "pipeline-dados-gcp"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_pubsub_subscription" "data_subscription" {
  name    = "data-subscription"
  topic   = google_pubsub_topic.data_topic.id
  project = "pipeline-dados-gcp"

  lifecycle {
    prevent_destroy = true
  }
}