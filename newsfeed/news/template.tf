data "google_compute_default_service_account" "default" {
}

data "google_compute_image" "my_image" {
  family  = "cos-cloud/cos-89-lts"
  project = var.project
}

resource "google_compute_instance_template" "foobar" {
  name           = var.template
  machine_type   = var.machinetype
  can_ip_forward = false
  tags           = ["foo", "bar"]

  disk {
    source_image = data.google_compute_image.my_image.self_link
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = var.network
  }

  scheduling {
    preemptible       = false
    automatic_restart = true
  }

  metadata = {
    gce-software-declaration = var.metadata_startup_script
    enable-guest-attributes = "true"
    enable-osconfig         = "true"

  }

  service_account {
    email  = google_service_account.joi-news-instances.email
    scopes = var.scopes
  }

  labels = {
    gce-service-proxy = "on"
  }
}
