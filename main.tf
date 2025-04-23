terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    bucket = "tfstate-pipeline-dados"   # Substitua pelo nome do seu bucket de estado
    prefix = "terraform/state"
  }

}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "infra" {
  source     = "./infra"
  project_id = "pipeline-dados-gcp"
  region     = "us-central1"
}
