resource "yandex_compute_instance" "natinstance" {
  
  name     = "${terraform.workspace}-natinstance"
  hostname = "natinstance"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_natinstance[terraform.workspace]
    memory = local.vm_memory_natinstance[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.nat_instance_id}"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.nat.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  vm_cores_natinstance = {
    "prod"=2
    "stage"=2
  }
  vm_memory_natinstance = {
    "prod"=2
    "stage"=2
  }
}