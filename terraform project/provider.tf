 provider "google" {
     credentials = "${lookup((var.gcp_auth_file),terraform.workspace)}"
     project     = "${lookup(var.project_name,terraform.workspace)}"
     region      = "${lookup(var.region,terraform.workspace)}"
     zone        = "${lookup(var.zone,terraform.workspace)}"
}