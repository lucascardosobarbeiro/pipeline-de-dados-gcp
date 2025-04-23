terraform {
  # backend "gcs" {
  #   bucket  = "meu-bucket-de-state"
  #   prefix  = "terraform/state"
  # }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}
