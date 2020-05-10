variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to private key used for provisioners"
}

variable root_enc_pass {
  description = "Temporary root pass"
}

variable firewall_ssh_source_ranges {
  default = ["0.0.0.0/0"]
}

variable zone1 {
  description = "zone1"
  default     = "europe-west1-b"
}

variable zone2 {
  description = "zone2"
  default     = "europe-west1-c"
}

variable zone3 {
  description = "zone3"
  default     = "europe-west1-d"
}
variable source_ranges_allow_http {
  description = "source_ranges allow http traffic"
  default     = ["0.0.0.0/0"]
}



#####################################################
# Monitoring
#####################################################
variable mon_zone {
  description = "Monitoring zone"
  default     = "europe-west1-b"
}

variable mon_disk_size {
  description = "Monitoring disk size"
  default     = 40
}
variable mon_disk_type {
  description = "Disk type: pd-standard or pd-ssd"
  default     = "pd-ssd"
}

#####################################################
# k8s
#####################################################

variable k8s_disk_size1 {
  description = "k8s disk size1"
  default     = 10
}

variable k8s_disk_size2 {
  description = "k8s disk size1"
  default     = 20
}
variable k8s_disk_type1 {
  description = "k8s Disk type1: pd-standard or pd-ssd"
  default     = "pd-standard"
}
variable k8s_disk_type2 {
  description = "k8s Disk type2: pd-standard or pd-ssd"
  default     = "pd-ssd"
}

#####################################################
# Logging
#####################################################
variable log_zone {
  description = "Logging zone"
  default     = "europe-west1-b"
}

variable log_disk_size {
  description = "Logging disk size"
  default     = 40
}
variable log_disk_type {
  description = "Disk type: pd-standard or pd-ssd"
  default     = "pd-ssd"
}

#####################################################
# nginx
#####################################################

variable nginx_disk_size {
  description = "Nginx disk size"
  default     = 10
}
variable nginx_disk_type {
  description = "Disk type: pd-standard or pd-ssd"
  default     = "pd-standard"
}

#####################################################
# haproxy
#####################################################

variable haproxy_disk_size {
  description = "haproxy disk size"
  default     = 10
}
variable haproxy_disk_type {
  description = "Disk type: pd-standard or pd-ssd"
  default     = "pd-standard"
}

#####################################################
# mongodb
#####################################################

variable mongodb_disk_size {
  description = "mongodb disk size"
  default     = 20
}
variable mongodb_disk_type {
  description = "Disk type: pd-standard or pd-ssd"
  default     = "pd-ssd"
}
