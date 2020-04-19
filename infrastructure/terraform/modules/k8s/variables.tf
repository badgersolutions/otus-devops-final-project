variable zone1 {
  default = "europe-west1-b"
}

variable zone2 {
  default = "europe-west1-c"
}

variable zone3 {
  default = "europe-west1-d"
}

variable disk_image {
  default = "ubuntu-1804-lts"
}
variable disk_size1 {
}
variable disk_type1 {
  description = "Disk type: pd-standard or pd-ssd"
  default = "pd-standard"
}
variable disk_size2 {
}
variable disk_type2 {
  description = "Disk type: pd-standard or pd-ssd"
  default = "pd-ssd"
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

variable bastion_host {
    description = "Host to provision"
}

variable network {
    description = "Network to which attach vm"
}

variable subnetwork {
    description = "Subnetwork to which attach vm"
}
