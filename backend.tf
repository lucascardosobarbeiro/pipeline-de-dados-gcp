terraform {
  backend "gcs" {
    bucket = "tfstate-pipeline-dados"
    prefix = "terraform/state"
  }
}
