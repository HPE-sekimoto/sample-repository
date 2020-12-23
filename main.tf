// GCP provider
variable "GOOGLE_CREDENTIALS" {}
variable "PROJECT_ID" {}

provider "google" {
  //credentials = file("./gcp_credential.json")
  credentials = "${var.GOOGLE_CREDENTIALS}"
  project     = "${var.PROJECT_ID}"
  region      = var.region
}

resource "google_compute_instance" "terraform-test" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  description  = "gcp-terraform-test"
  tags         = ["terraform-test"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro", "monitoring"]
  }
}
