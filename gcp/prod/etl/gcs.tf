resource "google_storage_bucket" "working_bucker" {
  name                        = "fincorp-prod-eu-working-bucket"
  location                    = "EU"
  force_destroy               = true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.working_bucker.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
