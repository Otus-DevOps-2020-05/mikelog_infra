terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "storage-bucket-stage"
    region                      = "us-east-1"
    key                         = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
