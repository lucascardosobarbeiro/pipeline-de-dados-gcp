/* ===============================
   ARQUIVO: outputs.tf
   =============================== */
output "bucket_name" {
  description = "Nome do bucket de dados"
  value       = google_storage_bucket.data_bucket.name
}

output "pubsub_topic" {
  description = "Tópico Pub/Sub usado para eventos de dados"
  value       = google_pubsub_topic.data_topic.name
}

output "pubsub_subscription" {
  description = "Subscription Pub/Sub usada para consumir eventos"
  value       = google_pubsub_subscription.data_subscription.name
}