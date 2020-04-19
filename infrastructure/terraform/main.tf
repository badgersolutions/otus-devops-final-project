terraform {
  # Версия terraform
  required_version = "~> 0.12.0"
}

provider "google" {
  # Версия провайдера
  version = "~> 2.5"
  # ID проекта
  project = var.project
  region  = var.region
}

resource "google_compute_network" "piggy-network" {
  name                    = "piggy-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "piggy-int-subnetwork" {
  name          = "piggy-int-subnetwork"
  ip_cidr_range = "10.0.1.0/26"
  region        = var.region
  network       = google_compute_network.piggy-network.self_link
}

resource "google_compute_firewall" "firewall_ssh" {
  name    = "piggy-allow-ssh"
  network = google_compute_network.piggy-network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.firewall_ssh_source_ranges
}

resource "google_compute_firewall" "firewall_internal" {
  name        = "piggy-allow-internal"
  description = "Allow internal traffic on the piggy network"
  network     = google_compute_network.piggy-network.name
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = [google_compute_subnetwork.piggy-int-subnetwork.ip_cidr_range]
}

resource "google_compute_instance" "bastion-vs" {
  name         = "bastion-vs"
  hostname     = "bastion.vs"
  machine_type = "custom-1-2048"
  zone         = var.zone2
  tags         = ["bastion"]
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-lts"
      size  = 10
      type  = "pd-standard"
    }
  }
  network_interface {
    network    = "piggy-network"
    subnetwork = "piggy-int-subnetwork"
    network_ip = "10.0.1.23"
    access_config {
      nat_ip = google_compute_address.bastion_ip.address
    }
  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}\nilyasemernya:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAF3EbKWauwXdhywSGi2cB5Zj0drZsjulqX4D82hwTESVz6P/qe5DZVOVUQNLNL//ihrCMS2kR7jCTFwP1QJdAaZiMhAcbA9P1YIOtzh8Qa69KLY1y4mWzXOg+Ukn3ZvhJLEtgVG7df6a91vxapZHgxzzfvcZXbnkxjGw4+RqRKJ4yRJEUD3FAsJyRGEoj7M3QEQ1w1Yx10uUefsY5AbFD8bmz4HgRGpmPWEY0o7cpHl6wEBA2RiRIguluCXKiRz9vLIDLwNh54grBPXvJzPT5zDqITGk+JLb1ulU47Y+OtTLfT/IiJVXF7kCG3xaE3VI2G/ViXwgoXIwqQSYBTYqVY8=\nilyasemernya:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBLWKJCRhaeIx++EH5E1nRR87pra0qY8qSuXL4WIrMvuvMdGBo5yO8aEAeANR0AJsoaj1qJV6MGIhyJaI7Ja0cRM= "
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].access_config[0].nat_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
  provisioner "remote-exec" {
    script     = "./files/permit_rootlogin.sh"
    on_failure = continue
  }
}

resource "google_compute_address" "bastion_ip" {
  name = "bastion-ip"
}

module "monitoring" {
  source           = "./modules/monitoring"
  zone             = var.mon_zone
  disk_size        = var.mon_disk_size
  disk_type        = var.mon_disk_type
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  root_enc_pass    = var.root_enc_pass
  # Раскомментировать, когда можно будет закрыть фаерволл
  #firewall_zab_source_ranges = google_compute_subnetwork.piggy-int-subnetwork.ip_cidr_range
  bastion_host     = google_compute_address.bastion_ip.address
  network = google_compute_network.piggy-network.name
  subnetwork = google_compute_subnetwork.piggy-int-subnetwork.name

}

module "k8s" {
  source           = "./modules/k8s"
  zone1            = var.zone1
  zone2            = var.zone2
  zone3            = var.zone3
  disk_size1       = var.k8s_disk_size1
  disk_size2       = var.k8s_disk_size2
  disk_type1       = var.k8s_disk_type1
  disk_type2       = var.k8s_disk_type2
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  root_enc_pass    = var.root_enc_pass
  bastion_host     = google_compute_address.bastion_ip.address
  network = google_compute_network.piggy-network.name
  subnetwork = google_compute_subnetwork.piggy-int-subnetwork.name

}

module "logging" {
  source           = "./modules/logging"
  zone             = var.log_zone
  disk_size        = var.log_disk_size
  disk_type        = var.log_disk_type
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  root_enc_pass    = var.root_enc_pass
  bastion_host     = google_compute_address.bastion_ip.address
  network = google_compute_network.piggy-network.name
  subnetwork = google_compute_subnetwork.piggy-int-subnetwork.name
}
module "nginx" {
  source           = "./modules/nginx"
  zone1            = var.zone1
  zone2            = var.zone2
  disk_size        = var.nginx_disk_size
  disk_type        = var.nginx_disk_type
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  root_enc_pass    = var.root_enc_pass
  bastion_host     = google_compute_address.bastion_ip.address
  network = google_compute_network.piggy-network.name
  subnetwork = google_compute_subnetwork.piggy-int-subnetwork.name

}

module "haproxy" {
  source           = "./modules/haproxy"
  zone1            = var.zone1
  zone2            = var.zone2
  disk_size        = var.haproxy_disk_size
  disk_type        = var.haproxy_disk_type
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  root_enc_pass    = var.root_enc_pass
  bastion_host     = google_compute_address.bastion_ip.address
  network = google_compute_network.piggy-network.name
  subnetwork = google_compute_subnetwork.piggy-int-subnetwork.name

}
module "mongo" {
  source           = "./modules/mongo"
  zone1            = var.zone1
  zone2            = var.zone2
  disk_size        = var.mongodb_disk_size
  disk_type        = var.mongodb_disk_type
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  root_enc_pass    = var.root_enc_pass
  bastion_host     = google_compute_address.bastion_ip.address
  network = google_compute_network.piggy-network.name
  subnetwork = google_compute_subnetwork.piggy-int-subnetwork.name

}
