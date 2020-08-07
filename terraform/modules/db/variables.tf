variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}

variable subnet_id {
description = "Subnets for modules"
}

variable private_key_path {
  description = "Path to private key used for provisioners"
  default = "~/.ssh/id_rsa"
}

variable use_provisioner {
  description = "Enable the use of provisioner"
  default     = "true"
}
