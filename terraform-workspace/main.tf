 provider "google" {
     credentials = file(var.json)
     project     = var.project
     region      = var.region
     zone        = var.zone
}

locals {
  name = "${terraform.workspace}-instance" 
}

resource "google_compute_instance" "VM-instance" {
  name = local.name
  machine_type = var.machine_type


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
