
output "n1-mongodb_internal_ip" {
  value = google_compute_instance.n1-mongodb-vs.network_interface[0].network_ip
}
output "n2-mongodb_internal_ip" {
  value = google_compute_instance.n2-mongodb-vs.network_interface[0].network_ip
}
