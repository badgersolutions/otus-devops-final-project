
output "mon_internal_ip" {
  value = google_compute_instance.n1-monitoring-vs.network_interface[0].network_ip
}
