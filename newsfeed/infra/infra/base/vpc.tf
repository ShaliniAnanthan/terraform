# # Define a vpc
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${var.prefix}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-${var.prefix}"
  ip_cidr_range = "10.5.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}
# locals {
#   allow_internal =[{
#     port = ["443"]
#     protocal ="tcp"
#   },
#   {
#      port = ["80"]
#     protocal ="udp"
#   }
#   ]
# }

# // VPC firewall configuration
# resource "google_compute_firewall" "allow-internal" {
#   name    = "allow-inernal-firewall"
#   network = "${google_compute_network.vpc.name}"
#   source_ranges =[var.subnet_cidr]

# dynamic "allow_internal" {
# for_each = local.allow_internal
# content{
#   protocal =allow_internal.value.protocal
#   ports =allow_internal.value.port
# }
# }

  # allow {
  #   protocol = "tcp"
  #   ports    = ["80"]  
  # }
  #   allow {
  #   protocol = "tcp"
  #   ports    = ["22"] 
  # }

  
# }
# resource "google_compute_firewall" "allow-http" {
#   name    = "allow-http"
#   network = "${google_compute_network.vpc.name}"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   source_ranges =[var.subnet_cidr]
#   target_tags = ["http"]
#   }

resource "google_compute_router" "router" {
  name    = "router-${var.prefix}"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat-router-${var.prefix}"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

