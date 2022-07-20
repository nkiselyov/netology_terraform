output "external_ip_nginx" {
  value = "${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_nginx" {
  value = "${yandex_compute_instance.nginx.network_interface.0.ip_address}"
}

output "internal_ip_address_mysql_db1" {
  value = "${yandex_compute_instance.db1.network_interface.0.ip_address}"
}

output "internal_ip_address_mysql_db2" {
  value = "${yandex_compute_instance.db2.network_interface.0.ip_address}"
}

output "internal_ip_address_wordpress" {
  value = "${yandex_compute_instance.wordpress.network_interface.0.ip_address}"
}

output "internal_ip_address_nat-instance" {
  value = "${yandex_compute_instance.natinstance.network_interface.0.ip_address}"
}

output "external_nat-instance" {
  value = "${yandex_compute_instance.natinstance.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_gitlab-ce" {
  value = "${yandex_compute_instance.gitlab-ce.network_interface.0.ip_address}"
}

output "internal_ip_address_gitlab-runner" {
  value = "${yandex_compute_instance.gitlab-runner.network_interface.0.ip_address}"
}

output "internal_ip_address_monitoring" {
  value = "${yandex_compute_instance.monitoring.network_interface.0.ip_address}"
}
