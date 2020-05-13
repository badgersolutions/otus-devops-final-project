resource "google_compute_instance_group" "mn1-k8s" {
  name = "mn1-k8s"
  zone = var.zone1
  instances = [
    google_compute_instance.mn1-k8s-vs.self_link
  ]
}
resource "google_compute_instance_group" "mn2-k8s" {
  name = "mn2-k8s"
  zone = var.zone2
  instances = [
    google_compute_instance.mn2-k8s-vs.self_link
  ]

}
resource "google_compute_instance_group" "mn3-k8s" {
  name = "mn3-k8s"
  zone = var.zone3
  instances = [
    google_compute_instance.mn3-k8s-vs.self_link
  ]

}
resource "google_compute_instance_group" "wn1-k8s" {
  name = "wn1-k8s"
  zone = var.zone1
  instances = [
    google_compute_instance.wn1-k8s-vs.self_link
  ]

}
resource "google_compute_instance_group" "wn2-k8s" {
  name = "wn2-k8s"
  zone = var.zone2
  instances = [
    google_compute_instance.wn2-k8s-vs.self_link
  ]

}
resource "google_compute_instance_group" "wn3-k8s" {
  name = "wn3-k8s"
  zone = var.zone3
  instances = [
    google_compute_instance.wn3-k8s-vs.self_link
  ]

}


resource "google_compute_region_backend_service" "k8s-lb" {
  #provider = google-beta
  name                  = "k8s-lb"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"
  protocol              = "TCP"

  backend {
    group = google_compute_instance_group.mn1-k8s.self_link
  }

  backend {
    group = google_compute_instance_group.mn2-k8s.self_link
  }
  backend {
    group = google_compute_instance_group.mn3-k8s.self_link
  }
  backend {
    group = google_compute_instance_group.wn1-k8s.self_link
  }
  backend {
    group = google_compute_instance_group.wn2-k8s.self_link
  }
  backend {
    group = google_compute_instance_group.wn3-k8s.self_link
  }


  health_checks = [
    "${google_compute_health_check.hc-k8s-ingress.self_link}",
  ]

  connection_draining_timeout_sec = 300
}



resource "google_compute_health_check" "hc-k8s-ingress" {
  name               = "hc-k8s-ingress-2"
  check_interval_sec = var.hc_check_interval_sec_ingress
  timeout_sec        = var.hc_timeout_sec_ingress
  tcp_health_check {
    port = var.health_check_port_ingress
  }
  unhealthy_threshold = 3

}


resource "google_compute_address" "ingress-k8s" {
  name         = "ingress-k8s"
  address_type = "INTERNAL"
  address      = var.ingress-k8s-lb-address
  subnetwork   = var.subnetwork

}

resource "google_compute_forwarding_rule" "k8s-ingress" {
  #provider = google-beta
  name                  = "k8s-ingress"
  load_balancing_scheme = "INTERNAL"
  ip_protocol           = "TCP"
  backend_service       = google_compute_region_backend_service.k8s-lb.self_link
  ip_address            = google_compute_address.ingress-k8s.address
  all_ports             = true
  network               = var.network
  subnetwork            = var.subnetwork

}

