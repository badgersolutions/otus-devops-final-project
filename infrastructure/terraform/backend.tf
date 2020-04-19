terraform {
  backend "gcs" {
    bucket = "piggy-storage-bucket"
    prefix = "terraform/state/"
  }
}
