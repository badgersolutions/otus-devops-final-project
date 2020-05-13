resource "google_compute_firewall" "firewall_ssh" {
  name    = "piggy-allow-http"
  network = var.network
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }


  source_ranges = var.firewall_zab_source_ranges
  target_tags   = ["monitoring"]
}
