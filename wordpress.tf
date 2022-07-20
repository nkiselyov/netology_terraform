resource "yandex_compute_instance" "wordpress" {
  
  name     = "${terraform.workspace}-wordpress"
  hostname = "app.bylobyslavno.ru"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_wordpress[terraform.workspace]
    memory = local.vm_memory_wordpress[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.zone1-a.id
    ip_address = local.vm_ip_wordpress[terraform.workspace]
  }

  metadata = {
    user-data = "${file("./user_wordpress.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  vm_cores_wordpress = {
    "prod"=4
    "stage"=4
  }
  vm_memory_wordpress = {
    "prod"=4
    "stage"=4
  }
  vm_ip_wordpress = {
    "prod"="192.168.101.13"
    "stage"="192.168.201.13"
  }
}