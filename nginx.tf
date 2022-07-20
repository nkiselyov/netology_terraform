resource "yandex_compute_instance" "nginx" {
  
  name     = "${terraform.workspace}-nginx"
  hostname = "bylobyslavno.ru"
  zone     = "ru-central1-a"
  resources {
    cores  = local.vm_cores_nginx[terraform.workspace]
    memory = local.vm_memory_nginx[terraform.workspace]
  }

  boot_disk {
    initialize_params {
      image_id = "${var.centos_image_id}"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.zone1-a.id
    nat       = true
    ip_address = local.vm_ip_nginx[terraform.workspace]
  }

  metadata = {
    user-data = "${file("./user.yml")}"
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "yandex_dns_recordset" "www" {
  zone_id = "${var.dns_zone}"
  name    = local.dns_record.www[terraform.workspace]
  type    = "A"
  ttl     = 200
  data    = ["${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "gitlab" {
  zone_id = "${var.dns_zone}"
  name    = local.dns_record.gitlab[terraform.workspace]
  type    = "A"
  ttl     = 200
  data    = ["${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "grafana" {
  zone_id = "${var.dns_zone}"
  name    = local.dns_record.grafana[terraform.workspace]
  type    = "A"
  ttl     = 200
  data    = ["${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "prometheus" {
  zone_id = "${var.dns_zone}"
  name    = local.dns_record.prometheus[terraform.workspace]
  type    = "A"
  ttl     = 200
  data    = ["${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"]
}

resource "yandex_dns_recordset" "alertmanager" {
  zone_id = "${var.dns_zone}"
  name    = local.dns_record.alertmanager[terraform.workspace]
  type    = "A"
  ttl     = 200
  data    = ["${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"]
}


locals {
  vm_cores_nginx = {
    "prod"=2
    "stage"=2
  }
  vm_memory_nginx = {
    "prod"=2
    "stage"=2
  }
  vm_ip_nginx = {
    "prod"="192.168.101.15"
    "stage"="192.168.201.15"
  }
  dns_record = {
    "www" = {
      "prod"="www"
      "stage"="www-stage"
    }
    "gitlab" = {
      "prod"="gitlab"
      "stage"="gitlab-stage"
    }
    "grafana" = {
      "prod"="grafana"
      "stage"="grafana-stage"
    }
    "prometheus" = {
      "prod"="prometheus"
      "stage"="prometheus-stage"
    }
    "alertmanager" = {
      "prod"="alertmanager"
      "stage"="alertmanager-stage"
    }
  }
}