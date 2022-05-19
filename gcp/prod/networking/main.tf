terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "gcp-prod-eu-west-vpc"
    }
  }
}

resource "google_compute_network" "vpc" {
  name                    = "fincorp-prod-vpc"
  description             = "Fincorp Prod VPC"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  name          = "fincorp-prod-public-subnet"
  description   = "Subnet for public instances only"
  ip_cidr_range = "10.99.0.0/24"
  network       = google_compute_network.vpc.id

  secondary_ip_range {
    range_name    = "secondary"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_subnetwork" "private" {
  name                     = "fincorp-prod-private-subnet"
  description              = "Subnet for private instances only"
  ip_cidr_range            = "10.99.1.0/24"
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "app_firewall" {
  name          = "fincorp-prod-app-firewall"
  network       = google_compute_network.vpc.id
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["80", "0-65535"]
  }
}
