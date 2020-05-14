###### hap1.k8s.vs
resource "google_compute_instance" "hap1-k8s-vs" {
  name = "hap1-k8s-vs"
  #hostname = "hap1.k8s.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone1
  tags         = ["k8s", "haproxy"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size1
      type  = var.disk_type1
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.12"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].network_ip
    user        = "svc_terraform"
    agent       = false
    private_key = file(var.private_key_path)

    bastion_host = var.bastion_host
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname hap1.k8s.vs"]
  }
}


###### hap2.k8s.vs
resource "google_compute_instance" "hap2-k8s-vs" {
  name = "hap2-k8s-vs"
  #hostname = "hap2.k8s.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone2
  tags         = ["k8s", "haproxy"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size1
      type  = var.disk_type1
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.13"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname hap2.k8s.vs"]
  }

}

###### mn1.k8s.vs
resource "google_compute_instance" "mn1-k8s-vs" {
  name = "mn1-k8s-vs"
  #hostname = "mn1.k8s.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone1
  tags         = ["k8s", "master-node"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size1
      type  = var.disk_type1
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.14"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname mn1.k8s.vs"]
  }
}

###### mn2.k8s.vs
resource "google_compute_instance" "mn2-k8s-vs" {
  name = "mn2-k8s-vs"
  #hostname = "mn2.k8s.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone2
  tags         = ["k8s", "master-node"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size1
      type  = var.disk_type1
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.15"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 
  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname mn2.k8s.vs"]
  }
}

###### mn3.k8s.vs
resource "google_compute_instance" "mn3-k8s-vs" {
  name = "mn3-k8s-vs"
  #hostname = "mn3.k8s.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone3
  tags         = ["k8s", "master-node"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size1
      type  = var.disk_type1
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.16"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname mn3.k8s.vs"]
  }
}


###### wn1.k8s.vs
resource "google_compute_instance" "wn1-k8s-vs" {
  name = "wn1-k8s-vs"
  #hostname = "wn1.k8s.vs"
  machine_type = "custom-2-4096"
  zone         = var.zone1
  tags         = ["k8s", "worker-node"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size2
      type  = var.disk_type2
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.17"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 
  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname wn1.k8s.vs"]
  }
}


###### wn2.k8s.vs
resource "google_compute_instance" "wn2-k8s-vs" {
  name = "wn2-k8s-vs"
  #hostname = "wn2.k8s.vs"
  machine_type = "custom-2-4096"
  zone         = var.zone2
  tags         = ["k8s", "worker-node"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size2
      type  = var.disk_type2
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.18"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname wn2.k8s.vs"]
  }
}


###### wn3.k8s.vs
resource "google_compute_instance" "wn3-k8s-vs" {
  name = "wn3-k8s-vs"
  #hostname = "wn3.k8s.vs"
  machine_type = "custom-2-4096"
  zone         = var.zone3
  tags         = ["k8s", "worker-node"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size2
      type  = var.disk_type2
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.19"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname wn3.k8s.vs"]
  }
}
###### nfs1.k8s.vs
resource "google_compute_instance" "nfs1-k8s-vs" {
  name         = "nfs1-k8s-vs"
  machine_type = "custom-1-2048"
  zone         = var.zone3
  tags         = ["k8s", "nfs"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size2
      type  = var.disk_type2
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.28"

  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface[0].network_ip
    user  = "svc_terraform"
    agent = false
    # путь до приватного ключа
    private_key  = file(var.private_key_path)
    bastion_host = var.bastion_host
  }
  provisioner "remote-exec" {
    inline = [
      "echo 'root:${var.root_enc_pass}'  | sudo chpasswd -e"
    ]
  }
 

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname nfs1.k8s.vs"]
  }
}
