# Setup our GCP provider
provider "google" {
  project     = var.project
  region      = var.region
  credentials = "gcp-auth.json"
}

# terraform {
#   backend "gcs" {
#     prefix      = "base"
#     credentials = "gcp-auth.json"
#   }
# }
