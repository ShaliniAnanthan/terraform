data "template_file" "front_end_init_script" {
  template = file("${path.module}../provision-front_end.sh")
  vars = {
    docker_image = var.image
    quote_service_url    = "http://${google_compute_instance.quotes.network_interface.0.access_config.0.nat_ip}:8082",
    newsfeed_service_url = "http://${google_compute_instance.newsfeed.network_interface.0.access_config.0.nat_ip}:8081",
    static_url           = "https://storage.googleapis.com/${google_storage_bucket.news.name}"
  }
}

data "template_file" "quotes_init_script" {
  template = file("${path.module}../provision-quotes.sh")
  vars = {
    docker_image = "${local.gcr_url}/quotes"
  }
}
data "template_file" "newsfeed_init_script" {
  template = file("${path.module}../provision-newsfeed.sh")
  vars = {
    docker_image = "${local.gcr_url}/newsfeed:latest"
  }
}