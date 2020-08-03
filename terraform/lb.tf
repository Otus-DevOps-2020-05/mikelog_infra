
resource "yandex_lb_target_group" "reddit-target-group" {
  name      = "reddit-target-group"
  region_id = var.zone
  dynamic "target"{
    for_each = [ for instance in  yandex_compute_instance.app:{
        address = instance.network_interface.0.ip_address
        subnet_id = var.subnet_id
      }
     ]
    content {
      subnet_id = target.value.subnet_id
      address = target.value.address
    }
  }
}

resource "yandex_lb_network_load_balancer" "reddit-lb" {
  name = "reddit-lb"

  listener {
    name = "reddit-lb"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-target-group.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
      }
    }
  }
}
