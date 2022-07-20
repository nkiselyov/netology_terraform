# Provider
terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
 
  # S3 bucket
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "bylobyslavno"
    region     = "ru-central1"
    key        = "state/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}
