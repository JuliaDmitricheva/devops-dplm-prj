terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket = "sfterraform-state"
    key    = "edu/sfterraform.tfstate"
    region     = "ru-central1-b"
    access_key = "YCAJECYrauSjIdtIXnOGGjfpp"
    secret_key = "YCOz5Mf2waPxuY68ghDut4NdZ98mEZZHzz3glnxs"
    skip_credentials_validation = true
    skip_region_validation      = true
  }
}

provider "yandex" {
#  service_account_key_file = file("./.sa_key.json")
  token     = var.sftoken
  cloud_id  = var.sfcloud_id
  folder_id = var.sffolder_id
  zone      = var.zone
}


resource "yandex_vpc_network" "sfnet1" {
  name = "sfnet1"
}

resource "yandex_vpc_subnet" "sfsubnet1" {
  name           = "sfsubnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.sfnet1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_compute_instance" "vm1" {
  name = "vm1"
  zone = "ru-central1-b"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8mn5e1cksb3s1pcq12"
      size     = "100"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfsubnet1.id
    nat       = true
    ip_address = "192.168.1.10"
  }

  metadata = {
    user-data = "${file("./user-metadata.txt")}"
  }

}



resource "yandex_compute_instance" "vm2" {
  name = "vm2"
  zone = "ru-central1-b"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8mn5e1cksb3s1pcq12"
      size     = "100"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sfsubnet1.id
    nat       = true
    ip_address = "192.168.1.11"
  }

  metadata = {
    user-data = "${file("./user-metadata.txt")}"
  }

}


