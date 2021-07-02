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

#compute instance with web tag to enable firewall rule association
resource "google_compute_instance" "default" {
  name         = "testvm1"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["web"]

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

  metadata_startup_script = "sudo apt update && sudo apt -y install apache2 && echo '<!doctype html><html><body><h1>Hello World!</h1></body></html>' | sudo tee /var/www/html/index.html"
}

resource "google_compute_firewall" "web" {
  name    = "allow-http"
  network = "default"
  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  target_tags = ["web"]
}

#public IP address for compute instance
output "public_ip_addr" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}