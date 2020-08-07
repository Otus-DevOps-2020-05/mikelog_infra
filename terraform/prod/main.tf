terraform {
  required_version = " ~> 0.12.8"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}
module "app" {
  source          = "../modules/app"
  public_key_path = var.public_key_path
	private_key_path = var.private_key_path
  app_disk_image  = var.app_disk_image
  subnet_id       = module.vpc.subnet_id
	db_internal_ip   = module.db.db_internal_ip
  use_provisioner  = "true"
}

module "db" {
  source          = "../modules/db"
  public_key_path = var.public_key_path
	private_key_path = var.private_key_path
  db_disk_image   = var.db_disk_image
  subnet_id       = module.vpc.subnet_id
}

module "vpc" {
  source          = "../modules/vpc"
  zone            = var.zone
  network_name    = var.network_name
  subnet_name     = var.subnet_name
  cidr_blocks     = var.cidr_blocks
}
