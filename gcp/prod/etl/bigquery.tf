module "bigquery" {
  source = "terraform-google-modules/bigquery/google"
  version = "~> 5.4"

  dataset_id                 = "payments"
  dataset_name               = "Payments"
  project_id                 = var.project
  location                   = "EU"
  delete_contents_on_destroy = true
  tables = [
    {
      table_id           = "payments",
      schema             = file("bq_schema.json"),
      time_partitioning  = null,
      range_partitioning = null,
      expiration_time    = 2524604400000, # 2050/01/01
      clustering         = [],
      labels = {
        environment = "prod"
      },
    }
  ]
}
