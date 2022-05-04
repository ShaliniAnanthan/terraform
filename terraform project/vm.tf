locals {
  name = "${terraform.workspace}-instance" 
}

resource "google_compute_instance" "VM-instance" {
  name = "${lookup(var.app_name,terraform.workspace)}-vm"
  machine_type = "${lookup(var.machine_type,terraform.workspace)}"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "${google_compute_network.vpc.name}"
    subnetwork = "${google_compute_subnetwork.subnet.name}"


    access_config {
      // Ephemeral IP
    }
  }
}
# resource "google_storage_bucket" "default" {
#   name = "gcptfstate"
#   project = "gcp-terraform-348507"
#   storage_class = "REGIONAL"
#   location = "us-west1"  
# }