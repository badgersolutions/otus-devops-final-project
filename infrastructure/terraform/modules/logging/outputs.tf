
output "log_internal_ip" {
  value = google_compute_instance.n1-logging-vs.network_interface[0].network_ip
}
