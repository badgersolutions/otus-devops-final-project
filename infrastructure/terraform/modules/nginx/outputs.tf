
output "n1-nginx_internal_ip" {
  value = google_compute_instance.n1-nginx-vs.network_interface[0].network_ip
}
output "n2-nginx_internal_ip" {
  value = google_compute_instance.n2-nginx-vs.network_interface[0].network_ip
}
#output "nginx-http-lb-address" {
#  value = google_compute_address.nginx-http-lb-address
#}
