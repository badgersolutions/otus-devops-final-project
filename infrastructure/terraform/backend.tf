terraform {
  backend "gcs" {
    bucket = "storage-bucket-terra"
    prefix = "terraform/state/"
  }
}
