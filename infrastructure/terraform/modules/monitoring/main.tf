resource "google_compute_instance" "n1-monitoring-vs" {
  name = var.vm_name
  #hostname = var.hostname
  machine_type = "custom-2-4096"
  zone = var.zone
  tags = ["monitoring"]
  boot_disk {
    initialize_params {
      image = var.disk_image
      size = var.disk_size
      type = var.disk_type
      }
 }
  network_interface {
    network = var.network
    subnetwork = var.subnetwork
    network_ip = "10.0.1.11"
    access_config {
      nat_ip = google_compute_address.mon_ip.address
    }
  }
  metadata = {
    ssh-keys = "svc_terraform:${file(var.public_key_path)}"
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
    script = "./files/permit_rootlogin.sh"
    on_failure = continue
  }

  provisioner "remote-exec" {
    inline = ["sudo hostnamectl set-hostname n1.monitoring.vs"]
  }

}

resource "google_compute_address" "mon_ip" {
  name = "monitoring-ip"
}
