resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
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

resource "null_resource" "provisioner-db" {
  count = "${var.use_provisioner ? 1 : 0}"

  connection {
    host        = yandex_compute_instance.db.network_interface.0.nat_ip_address
    type        = "ssh"
    user        = "ubuntu"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "${path.module}/files/mongod.conf"
    destination = "/tmp/mongod.conf"
  }

	#provisioner "remote-exec" {
  #  script = "${path.module}/files/nstall_mongodb.sh"
  #}

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/mongod.conf /etc/mongod.conf",
      "sudo service mongod restart",
    ]
  }
}
