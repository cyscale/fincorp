resource "google_storage_bucket_object" "function_code" {
  name   = "fincorp-etl-code.zip"
  bucket = google_storage_bucket.working_bucket.name
  source = "main.zip"
}

resource "google_cloud_scheduler_job" "this" {
  name        = "fincorp-prod-eu-west-etl-job"
  description = "Trigger the ETL job"
  schedule    = "* * * * *"

  pubsub_target {
    topic_name = google_pubsub_topic.etl_topic.id
    data       = base64encode("new payment")
  }
}

resource "google_cloudfunctions_function" "this" {
  name        = "fincorp-prod-eu-west-etl-handler"
  description = "Fincorp ETL handler"
  runtime     = "python39"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.working_bucket.name
  source_archive_object = google_storage_bucket_object.function_code.name
  entry_point           = "process"

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.etl_topic.name
  }
}
