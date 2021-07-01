terraform {
    required_providers {
        google = "~> 3.0.0"
    }
}
provider "google" {
    project = var.project_id
    region  = var.region
    zone    = var.zone
}

resource "google_service_account" "default" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
}

resource "google_compute_instance" "default" {
  name         = "testvm1"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["foo", "bar"]

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
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}