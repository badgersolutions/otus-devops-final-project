resource "google_compute_instance" "n1-haproxy-vs" {
  name = "n1-haproxy-vs"
  #hostname = "n1.haproxy.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone1
  tags         = ["haproxy"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size
      type  = var.disk_type
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.24"

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
    script     = "./files/permit_rootlogin.sh"
    on_failure = continue
  }
  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname n1.haproxy.vs"]
  }

}

resource "google_compute_instance" "n2-haproxy-vs" {
  name = "n2-haproxy-vs"
  #hostname = "n2.haproxy.vs"
  machine_type = "custom-1-4096"
  zone         = var.zone2
  tags         = ["haproxy"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size  = var.disk_size
      type  = var.disk_type
    }
  }
  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.25"

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
    script     = "./files/permit_rootlogin.sh"
    on_failure = continue
  }

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname n2.haproxy.vs"]
  }

}
