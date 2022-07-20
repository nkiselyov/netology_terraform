resource "yandex_compute_instance" "gitlab-ce" {
  name     = "${terraform.workspace}-gitlab"
  hostname = "gitlab.bylobyslavno.ru"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_gitlab-ce[terraform.workspace]
    memory = local.vm_memory_gitlab-ce[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
      size = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.zone1-a.id}"
    ip_address = local.vm_ip_gitlab-ce[terraform.workspace]
  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "yandex_compute_instance" "gitlab-runner" {
  name     = "${terraform.workspace}-runner"
  hostname = "runner.bylobyslavno.ru"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_gitlab-runner[terraform.workspace]
    memory = local.vm_memory_gitlab-runner[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
      size = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.zone1-a.id}"
    ip_address = local.vm_ip_gitlab-runner[terraform.workspace]
  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}


locals {
  vm_cores_gitlab-ce = {
    "prod"=4
    "stage"=4
  }
  vm_memory_gitlab-ce = {
    "prod"=4
    "stage"=4
  }
  vm_cores_gitlab-runner = {
    "prod"=4
    "stage"=4
  }
  vm_memory_gitlab-runner = {
    "prod"=4
    "stage"=4
  }
  vm_ip_gitlab-ce = {
    "prod"="192.168.101.4"
    "stage"="192.168.201.4"
  }
  vm_ip_gitlab-runner = {
    "prod"="192.168.101.31"
    "stage"="192.168.201.31"
  }
}