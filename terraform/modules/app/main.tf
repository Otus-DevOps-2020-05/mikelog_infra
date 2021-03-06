resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
   subnet_id = var.subnet_id
   nat = true
 }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

resource "null_resource" "provisioner-app" {
  count = "${var.use_provisioner ? 1 : 0}"
  connection {
    type  = "ssh"
    host  = yandex_compute_instance.app.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    content     = "${data.template_file.puma.rendered}"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}

data "template_file" "puma" {
  template = templatefile("${path.module}/files/puma.service.tpl", { db_internal_ip = var.db_internal_ip })
}
