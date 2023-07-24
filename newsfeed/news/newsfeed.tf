resource "google_compute_instance" "newsfeed" {
name = var.display_name
machine_type = var.machine_type
zone =var.zone
tags = var.tags
boot_disk {
  initialize_params {
      image = var.imagename
    }
}
metadata_startup_script = {
    file("${path.module}/

}
network_interface {
    subnetwork = data.google_compute_subnetwork.subnet.self_link
}
access_config {
      # nat_ip = google_compute_address.nat.address
    }
service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.joi-news-instances.email
    scopes = var.service_account_scopes
  }
}

# resource "google_compute_firewall" "newsfeed" { 
#  name    = name.firewallrule
#   network = data.google_compute_network.default.name 
# }