resource "yandex_compute_instance" "db1" {
  name     = "${terraform.workspace}-db01"
  hostname = "db01.bylobyslavno.ru"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_mysql[terraform.workspace]
    memory = local.vm_memory_mysql[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
      size = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.zone1-a.id}"
    ip_address = local.vm_ip_db1[terraform.workspace]

  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "yandex_compute_instance" "db2" {
  name     = "${terraform.workspace}-db02"
  hostname = "db02.bylobyslavno.ru"
  zone     = "ru-central1-b"
  resources {
    cores  = local.vm_cores_mysql[terraform.workspace]
    memory = local.vm_memory_mysql[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
      size = 20
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.zone1-b.id}"
    ip_address = local.vm_ip_db2[terraform.workspace]

  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}


locals {
  vm_cores_mysql = {
    "prod"=4
    "stage"=2
  }
  vm_memory_mysql = {
    "prod"=4
    "stage"=2
  }
  vm_ip_db1 = {
    "prod"="192.168.101.8"
    "stage"="192.168.201.8"
  }
  vm_ip_db2 = {
    "prod"="192.168.102.34"
    "stage"="192.168.202.34"
  }
  
}