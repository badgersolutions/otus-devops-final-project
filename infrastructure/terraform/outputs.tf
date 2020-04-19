
output "bastion_external_ip" {
  value = google_compute_address.bastion_ip.address
}
output "bastion_internal_ip" {
  value = google_compute_instance.bastion-vs.network_interface[0].network_ip
}



#####################################################
# Monitoring
#####################################################

output "mon_external_ip" {
  value = module.monitoring.mon_external_ip
}

output "mon_internal_ip" {
  value = module.monitoring.mon_internal_ip
}

#####################################################
# k8s
#####################################################

output "hap1_k8s_internal_ip" {
  value = module.k8s.hap1_k8s_internal_ip
}


output "hap2_k8s_internal_ip" {
  value = module.k8s.hap2_k8s_internal_ip
}


output "mn1_k8s_internal_ip" {
  value = module.k8s.mn1_k8s_internal_ip
}


output "mn2_k8s_internal_ip" {
  value = module.k8s.mn2_k8s_internal_ip
}


output "mn3_k8s_internal_ip" {
  value = module.k8s.mn3_k8s_internal_ip
}


output "wn1_k8s_internal_ip" {
  value = module.k8s.wn1_k8s_internal_ip
}


output "wn2_k8s_internal_ip" {
  value = module.k8s.wn2_k8s_internal_ip
}


output "wn3_k8s_internal_ip" {
  value = module.k8s.wn3_k8s_internal_ip
}

#####################################################
# logging
#####################################################

output "logging_internal_ip" {
  value = module.logging.log_internal_ip
}
#####################################################
# nginx
#####################################################

output "n1-nginx_internal_ip" {
  value = module.nginx.n1-nginx_internal_ip
}
output "n2-nginx_internal_ip" {
  value = module.nginx.n2-nginx_internal_ip
}
#####################################################
# haproxy
#####################################################

output "n1-haproxy_internal_ip" {
  value = module.haproxy.n1-haproxy_internal_ip
}
output "n2-haproxy_internal_ip" {
  value = module.haproxy.n2-haproxy_internal_ip
}
#####################################################
# mongodb
#####################################################

output "n1-mongodb_internal_ip" {
  value = module.mongo.n1-mongodb_internal_ip
}
output "n2-mongodb_internal_ip" {
  value = module.mongo.n2-mongodb_internal_ip
}
