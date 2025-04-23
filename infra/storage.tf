/* ===============================
   ARQUIVO: storage.tf
   =============================== */
resource "google_storage_bucket" "data_bucket" {
  name          = "pipeline-dados-gcp-data-bucket"
  location      = var.region
  project       = "pipeline-dados-gcp"
  force_destroy = true
}