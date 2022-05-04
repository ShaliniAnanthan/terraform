resource "google_compute_network" "vpc" {
  name                            = "${lookup (var.app_name,terraform.workspace)}-vpc"
  auto_create_subnetworks         = "false"
  routing_mode                    = "GLOBAL"
}

resource "google_compute_subnetwork" "subnet" {
 name          = "${lookup (var.app_name,terraform.workspace)}-subnet"
 ip_cidr_range = "${lookup(var.subnet_cidr,terraform.workspace)}"
 network       = "${google_compute_network.vpc.name}"
 region      = lookup(var.region,terraform.workspace)
}
// VPC firewall configuration
resource "google_compute_firewall" "allow-inernal" {
  name    = "${lookup (var.app_name,terraform.workspace)}-allow-inernal-firewall"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]  
  }
    allow {
    protocol = "udp"
    ports    = ["0-65535"] 
  }

  source_ranges =[
    "${lookup(var.subnet_cidr,terraform.workspace)}"
  ]
}