resource "google_compute_instance_group" "n1-nginx" {
  name = "n1-nginx"
  zone = var.zone1

  instances = [
      google_compute_instance.n1-nginx-vs.self_link
      ]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

}
resource "google_compute_instance_group" "n2-nginx" {
  name = "n2-nginx"
  zone = var.zone2 

  instances = [
      google_compute_instance.n2-nginx-vs.self_link
      ]

  named_port {
    name = "http"
    port = "80"
  }

  named_port {
    name = "https"
    port = "443"
  }

}

resource "google_compute_address" "nginx-http-lb-address" {
  name = "nginx-http-lb-address"
  address_type =  "EXTERNAL"
  network_tier =  "STANDARD"
  region = var.region
}

###### HTTP LOADBALANCER ######

resource "google_compute_backend_service" "nginx-http-backend" {
  name = "nginx-http-backend"
  protocol = "HTTP"
  load_balancing_scheme = "EXTERNAL"
  port_name = "http"
  #network = var.network
  backend {
    group = google_compute_instance_group.n1-nginx.self_link
  }
  backend {
    group = google_compute_instance_group.n2-nginx.self_link
  }
  health_checks = [
    "${google_compute_health_check.hc-nginx-http.self_link}",
  ]
}



resource "google_compute_health_check" "hc-nginx-http" {
  name               = "hc-nginx-http"
  check_interval_sec = var.hc_check_interval_sec
  timeout_sec        = var.hc_timeout_sec
  tcp_health_check {
    port = var.health_check_port
  }
  unhealthy_threshold = 3
}

resource "google_compute_url_map" "nginx-http-lb" {
  name            = "nginx-http-lb"
  default_service = google_compute_backend_service.nginx-http-backend.self_link
}

resource "google_compute_target_http_proxy" "nginx-http-lb-target-proxy" {
  name    = "nginx-http-lb-target-proxy"
  url_map = google_compute_url_map.nginx-http-lb.self_link
}



resource "google_compute_forwarding_rule" "nginx-http-lb-fr" {
  #provider = google-beta
  name       = "nginx-http-lb-fr"
  target     = google_compute_target_http_proxy.nginx-http-lb-target-proxy.self_link
  ip_address = google_compute_address.nginx-http-lb-address.address
  port_range = var.forwarding_rule_port_range
  region = var.region
}

###### HTTPS LOADBALANCER ######

resource "google_compute_backend_service" "nginx-https-lb-backend" {
  name = "nginx-https-lb-backend"
  protocol = "HTTPS"
  load_balancing_scheme = "EXTERNAL"
  port_name = "https"
  #network = var.network
  backend {
    group = google_compute_instance_group.n1-nginx.self_link
  }
  backend {
    group = google_compute_instance_group.n2-nginx.self_link
  }
  health_checks = [
    "${google_compute_health_check.hc-nginx-https.self_link}",
  ]
}



resource "google_compute_health_check" "hc-nginx-https" {
  name               = "hc-https"
  check_interval_sec = var.hc_check_interval_sec
  timeout_sec        = var.hc_timeout_sec_https
  tcp_health_check {
    port = var.health_check_port_https
  }
  unhealthy_threshold = 3
}

resource "google_compute_url_map" "nginx-https-lb" {
  name            = "nginx-https-lb"
  default_service = google_compute_backend_service.nginx-https-lb-backend.self_link
}

resource "google_compute_target_https_proxy" "nginx-https-lb-target-proxy" {
  name    = "nginx-https-lb-target-proxy"
  url_map = google_compute_url_map.nginx-https-lb.self_link
  ssl_certificates = [google_compute_ssl_certificate.semernya-cert.self_link]
}



resource "google_compute_forwarding_rule" "nginx-https-lb-fr" {
  #provider = google-beta
  name       = "nginx-https-lb-fr"
  load_balancing_scheme = "EXTERNAL"
  network_tier = "STANDARD"
  target     = google_compute_target_https_proxy.nginx-https-lb-target-proxy.self_link
  ip_address = google_compute_address.nginx-http-lb-address.address
  port_range = var.forwarding_rule_port_range_https
  region = var.region
}

resource "google_compute_ssl_certificate" "semernya-cert" {
  name = "semernya-cert"
  private_key = file("./files/semernya.key")
  certificate = file("./files/bundle.semernya.crt")

  #lifecycle {
  #  create_before_destroy = true
  #}
#
  timeouts {}
}
