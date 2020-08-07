variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable subnet_id {
  description = "Subnet ID"
}

variable image_id {
  description = "Image ID"
}
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
}

variable private_key_path {
  description = "Path to private key used for provisioners"
}

variable app_region {
  description = "App Region"
  default     = "ru-central1-a"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable service_account_key_file {
  description = "Path to auth ya cloud"
}
variable inst_cnt {
  description = "Count of instances"
  default     = "1"
}

variable app_disk_image {
description = "Disk image for reddit app"
default = "reddit-app-base"
}

variable db_disk_image {
description = "Disk image for reddit app"
default = "reddit-db-base"
}

variable network_name {
  description = "Network name"
  # Значение по умолчанию
  default = "app-network"
}

variable subnet_name {
  description = "Subnet name"
  # Значение по умолчанию
  default = "app-subnet"
}

variable cidr_blocks {
  description = "CIDR blocks"
  # Значение по умолчанию
  default = ["192.168.10.0/24"]
}
