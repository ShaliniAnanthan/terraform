# Setup our GCP provider
variable "region" {
  default = "us-central1"
}

variable "project" {
  default = "gcp-terraform-dev-379204"
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = "../base/gcp_auth.json"
}

terraform {
  backend "gcs" {
    bucket     = "newsfeed_state"
    prefix      = "base/news"
    credentials = "../base/gcp_auth.json"
  }
}

