

output "hap1_k8s_internal_ip" {
  value = google_compute_instance.hap1-k8s-vs.network_interface[0].network_ip
}


output "hap2_k8s_internal_ip" {
  value = google_compute_instance.hap2-k8s-vs.network_interface[0].network_ip
}


output "mn1_k8s_internal_ip" {
  value = google_compute_instance.mn1-k8s-vs.network_interface[0].network_ip
}


output "mn2_k8s_internal_ip" {
  value = google_compute_instance.mn2-k8s-vs.network_interface[0].network_ip
}


output "mn3_k8s_internal_ip" {
  value = google_compute_instance.mn3-k8s-vs.network_interface[0].network_ip
}


output "wn1_k8s_internal_ip" {
  value = google_compute_instance.wn1-k8s-vs.network_interface[0].network_ip
}


output "wn2_k8s_internal_ip" {
  value = google_compute_instance.wn2-k8s-vs.network_interface[0].network_ip
}


output "wn3_k8s_internal_ip" {
  value = google_compute_instance.hap1-k8s-vs.network_interface[0].network_ip
}
