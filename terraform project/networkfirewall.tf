resource "google_compute_firewall" "allow-http" {
  name    = "${lookup (var.app_name,terraform.workspace)}-allow-http"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges =[
    "${lookup(var.subnet_cidr,terraform.workspace)}"
  ]
  target_tags = ["http"]
  }
 
 resource "google_compute_firewall" "allow-ssh" {
  name    = "${lookup (var.app_name,terraform.workspace)}-allow-ssh"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges =[
    "${lookup(var.subnet_cidr,terraform.workspace)}"
  ]
  target_tags = ["ssh"]
  }
 
  resource "google_compute_firewall" "allow-rdp" {
  name    = "${lookup (var.app_name,terraform.workspace)}-allow-rdp"
  network = "${google_compute_network.vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges =[
    "${lookup(var.subnet_cidr,terraform.workspace)}"
  ]
  target_tags = ["rdp"]
  }
