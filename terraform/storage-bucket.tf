provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

resource "yandex_storage_bucket" "create_bucket" {
  bucket = ["storage-bucket-stage", "storage-bucket-prod"]
}
