##enable API
resource "google_project_service" "gcp_services" {
    for_each = toset(var.gcp_services_list)
    project = var.project
    service = each.value
     disable_dependent_services=true
}
##kms key 
resource "google_kms_key_ring" "keyring" {
  project = var.project
  name = "newsfeed-keyring"
  location = "europe"
  depends_on = [

    google_project_service.gcp_services
  ]
}
resource "google_kms_crypto_key" "key"{
  name  = "newsfeed_cryto_key"
  key_ring = google_kms_key_ring.keyring.id
}

# # Define a vpc
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-${var.prefix}"
  auto_create_subnetworks = false
  depends_on = [
    google_project_service.gcp_services
  ]
}

resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-${var.prefix}"
  ip_cidr_range = "10.5.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_router" "router" {
  name    = "router-${var.prefix}"
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.vpc_network.id
}


resource "google_compute_address" "nat" {
  name   = "nat-address1"
  region = google_compute_subnetwork.subnet.region
   depends_on = [
  google_project_service.gcp_services
   ]
}



resource "google_compute_router_nat" "nat_manual" {
  name   = "my-router-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = [google_compute_address.nat.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}


# resource "google_compute_router_nat" "nat" {
#   name                               = "nat-router-${var.prefix}"
#   router                             = google_compute_router.router.name
#   region                             = google_compute_router.router.region
#   nat_ip_allocate_option             = "AUTO_ONLY"
#   source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
# }
# locals {
#   ingress_rules =[{
#     port = ["80"]
#     protocol = "tcp"
#   },
#   {
#      port =["22"]
#      protocol = "tcp"
#   }
#   ] 
# }
# resource "google_compute_firewall" "allow-internal" {
#   name    = "allow-inernal-firewall"
#   network = google_compute_network.vpc_network.id
#   source_ranges = ["google_compute_subnetwork.subnet.ip_cidr_range"]

# dynamic "allow" {
# for_each = local.ingress_rules
# content{
#   ports = allow.value.port
#   protocol = allow.value.protocol
 
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






