resource "google_compute_instance_group" "hap1-k8s" {
  name = "hap1-k8s"
  zone = var.zone1

  instances = [
      google_compute_instance.hap1-k8s-vs.self_link
      ]

}
resource "google_compute_instance_group" "hap2-k8s" {
  name = "hap2-k8s"
  zone = var.zone2

  instances = [
      google_compute_instance.hap2-k8s-vs.self_link
      ]

}

resource "google_compute_region_backend_service" "hap-k8s-backend" {
  provider = google-beta
  name = "hap-k8s-backend"
  region = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  #network = var.network

  backend {
    group = google_compute_instance_group.hap1-k8s.self_link
  }

  backend {
    group = google_compute_instance_group.hap2-k8s.self_link
    failover = true
  }


  health_checks = [
    "${google_compute_health_check.hc-hap-6443.self_link}",
  ]
}



resource "google_compute_health_check" "hc-hap-6443" {
  name               = "hc-hap-6443"
  check_interval_sec = var.hc_check_interval_sec
  timeout_sec        = var.hc_timeout_sec
  tcp_health_check {
    port = var.health_check_port
  }
}

#resource "google_compute_url_map" "appurlmap" {
#  name            = "${var.name_app}-url-map"
#  default_service = google_compute_backend_service.appbackend.self_link
#}
#
#resource "google_compute_target_http_proxy" "apphttpproxy" {
#  name    = "${var.name_app}-proxy"
#  url_map = google_compute_url_map.appurlmap.self_link
#}

resource "google_compute_address" "hap-k8s-address" {
  name = "hap-k8s-address"
  address_type = "INTERNAL"
  address = var.hap-k8s-lb-address
  subnetwork = var.subnetwork
}

resource "google_compute_forwarding_rule" "hap-k8s-fr" {
  provider = google-beta
  name       = "hap-k8s-fr"
  load_balancing_scheme = "INTERNAL"
  backend_service     = google_compute_region_backend_service.hap-k8s-backend.self_link
  ip_address = google_compute_address.hap-k8s-address.address
  all_ports = true
  network = var.network
  subnetwork = var.subnetwork
}

