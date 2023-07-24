# Setup our GCP provider

provider "google" {
  project     = var.project
  region      = var.region
  credentials = "gcp_auth.json"
}

terraform {
  backend "gcs" {
    bucket     = "newsfeed_state"
    prefix      = "base"
    credentials = "gcp_auth.json"
  }
}
