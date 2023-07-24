# Setup our GCP provider
variable "region" {
  default = "us-central1"
}

variable "project" {
  default ="swift-firmament-358410"
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = "C:/Users/shalini.ananthan.DIR/OneDrive - Accenture/Desktop/Terraform/webserver/infra/base/gcp-auth.json"
}

# terraform {
#   backend "gcs" {
#     prefix      = "news"
#     credentials = "C:/Users/shalini.ananthan.DIR/OneDrive - Accenture/Desktop/Terraform/webserver/infra/base/gcp-auth.json"
#   }
# }
