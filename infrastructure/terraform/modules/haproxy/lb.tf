resource "google_compute_instance_group" "hap1-mongo" {
  name = "hap1-mongo"
  zone = var.zone1

  instances = [
    google_compute_instance.n1-haproxy-vs.self_link
  ]

}
resource "google_compute_instance_group" "hap2-mongo" {
  name = "hap2-mongo"
  zone = var.zone2

  instances = [
    google_compute_instance.n2-haproxy-vs.self_link
  ]

}

resource "google_compute_region_backend_service" "hap-mongo-backend" {
  provider              = google-beta
  name                  = "hap-mongo-backend"
  region                = "europe-west1"
  load_balancing_scheme = "INTERNAL"

  backend {
    group = google_compute_instance_group.hap1-mongo.self_link
  }

  backend {
    group    = google_compute_instance_group.hap2-mongo.self_link
    failover = true
  }


  health_checks = [
    "${google_compute_health_check.hc-mongo-27017.self_link}",
  ]
}



resource "google_compute_health_check" "hc-mongo-27017" {
  name               = "hc-mongo-27017"
  check_interval_sec = var.hc_check_interval_sec
  timeout_sec        = var.hc_timeout_sec
  tcp_health_check {
    port = var.health_check_port
  }
}


resource "google_compute_address" "hap-mongo-address" {
  name         = "hap-mongo-address"
  address_type = "INTERNAL"
  address      = var.hap-mongo-lb-address
  subnetwork   = var.subnetwork
}

resource "google_compute_forwarding_rule" "hap-mongo-fr" {
  provider              = google-beta
  name                  = "hap-mongo-fr"
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.hap-mongo-backend.self_link
  ip_address            = google_compute_address.hap-mongo-address.address
  all_ports             = true
  network               = var.network
  subnetwork            = var.subnetwork
}

