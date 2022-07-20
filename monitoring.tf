resource "yandex_compute_instance" "monitoring" {
  
  name     = "${terraform.workspace}-monitoring"
  hostname = "monitoring.bylobyslavno.ru"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_monitoring[terraform.workspace]
    memory = local.vm_memory_monitoring[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.zone1-a.id
    ip_address = local.vm_ip_monitoring[terraform.workspace]
  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

locals {
  vm_cores_monitoring = {
    "prod"=4
    "stage"=4
  }
  vm_memory_monitoring = {
    "prod"=4
    "stage"=4
  }
  vm_ip_monitoring = {
    "prod"="192.168.101.5"
    "stage"="192.168.201.5"
  }
}