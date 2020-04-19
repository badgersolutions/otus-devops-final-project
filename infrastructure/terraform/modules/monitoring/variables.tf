variable vm_name {
  description = "vm name"
  default = "n1-monitoring-vs"
}
variable hostname {
  description = "monitoring vm hostname"
  default = "n1.monitoring.vs"
}

variable zone {
  description = "Zone"
  default = "europe-west1-b"
}

variable disk_image {
  default = "ubuntu-1804-lts"
}
variable disk_size {
}
variable disk_type {
  description = "Disk type: pd-standard or pd-ssd"
  default = "pd-standard"
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

variable firewall_zab_source_ranges {
    description = "Source ranges to Zabbix firewall rule"
    default = ["0.0.0.0/0"]
}

variable bastion_host {
    description = "Host to provision"
}

variable network {
    description = "Network to which attach vm"
}

variable subnetwork {
    description = "Subnetwork to which attach vm"
}
