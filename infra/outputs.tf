output "bucket_name" {
  value = google_storage_bucket.data_bucket.name
}

output "function_name" {
  value = google_cloudfunctions_function.process_json.name
}
