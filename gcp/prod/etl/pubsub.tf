resource "google_pubsub_topic" "example" {
  name                       = "fincorp-prod-eu-west-etl-topic"
  message_retention_duration = "600s"
}
