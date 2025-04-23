terraform {
  backend "gcs" {
    bucket  = "NOME_DO_SEU_BUCKET_STATE"  # Substitua pelo nome real
    prefix  = "terraform/state"
  }
}
