resource "yandex_vpc_network" "app-network" {
name = var.network_name
}
resource "yandex_vpc_subnet" "app-subnet" {
name = var.subnet_name
zone = var.zone
network_id = "${yandex_vpc_network.app-network.id}"
v4_cidr_blocks = var.cidr_blocks
}
