resource "google_storage_bucket" "news" {
  name          = "${var.project}-infra-static-pages"
  force_destroy = true
  location      = "EU"

  uniform_bucket_level_access = true
  encryption {
    default_kms_key_name = data.google_kms_crypto_key.key1.id
  }

  website {
    main_page_suffix = "index.html"
    not_found_page   = "error.html"
  }
}
resource "google_project_iam_member" "google_compute_agent-kms"{
  project =var.project
  role ="roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member ="serviceAccount:service-441223354090@gs-project-accounts.iam.gserviceaccount.com"
}
data "google_kms_key_ring" "key_ring"{
  name = "newsfeed-keyring"
  location = "europe"
  project = var.project
}
data "google_kms_crypto_key" "key1"{
  name = "newsfeed_cryto_key"
  key_ring =data.google_kms_key_ring.key_ring.id
}
resource "google_storage_bucket_iam_binding" "news" {
  bucket = google_storage_bucket.news.name
  role = "roles/storage.objectViewer"
  members = [
    "allUsers"
  ]
}