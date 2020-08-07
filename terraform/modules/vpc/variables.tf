
variable zone {
  description = "Zone"
  # Значение по умолчанию
  default = "ru-central1-a"
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
