data "google_compute_zones" "zones" {}

resource "google_compute_instance" "etl_instance" {
  machine_type = "f1-micro"
  name         = "fincorp-prod-eu-west-etl-instance"
  zone         = data.google_compute_zones.zones.names[0]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
    auto_delete = true
  }
  network_interface {
    subnetwork = data.terraform_remote_state.vpc.outputs.private_subnet
  }
  can_ip_forward = true
  attached_disk {
    source      = google_compute_disk.unencrypted_disk.name
    device_name = "extra"
  }
}

resource "google_compute_disk" "unencrypted_disk" {
  name = "fincorp-prod-eu-west-disk"
  zone = data.google_compute_zones.zones.names[0]
}
