# Network
resource "yandex_vpc_network" "default" {
  name = "${terraform.workspace}-network"
}

resource "yandex_vpc_route_table" "nat-route" {
  network_id = "${yandex_vpc_network.default.id}"
  name = "${terraform.workspace}-nat-route-table"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "${yandex_compute_instance.natinstance.network_interface.0.ip_address}"
  }
}

resource "yandex_vpc_subnet" "nat" {
  name = "${terraform.workspace}-subnet-NAT"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = local.subnet_cidr[terraform.workspace].subnet-nat
}

resource "yandex_vpc_subnet" "zone1-a" {
  name = "${terraform.workspace}-subnet-1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = local.subnet_cidr[terraform.workspace].subnet-1
  route_table_id = yandex_vpc_route_table.nat-route.id
}

resource "yandex_vpc_subnet" "zone1-b" {
  name = "${terraform.workspace}-subnet-2"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = local.subnet_cidr[terraform.workspace].subnet-2
  route_table_id = yandex_vpc_route_table.nat-route.id
}


locals {
  subnet_cidr = {
    "prod"= {
      "subnet-1" = ["192.168.101.0/24"]
      "subnet-2" = ["192.168.102.0/24"]
      "subnet-nat" = ["192.168.103.0/24"]
    }
    "stage"= {
      "subnet-1" = ["192.168.201.0/24"]
      "subnet-2" = ["192.168.202.0/24"]
      "subnet-nat" = ["192.168.203.0/24"]
    }
  }
}