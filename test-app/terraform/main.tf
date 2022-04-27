data "archive_file" "source" {
    type = "zip"
    source_dir = var.source_path
    output_path = "${path.module}/output.zip"
    excludes = fileset("${var.source_path}/terraform", "*")
}


resource "google_storage_bucket" "test_app_gcs_repo" {
  project = var.project_id
  name          = var.gcs_source_bucket_name
  location      = var.gcs_source_bucket_location
}

resource "google_storage_bucket_object" "source_zip" {
    source       = data.archive_file.source.output_path
    content_type = "application/zip"

    name         = "${var.base_app_name}-src-${data.archive_file.source.output_md5}.zip"
    bucket       = google_storage_bucket.test_app_gcs_repo.name
}

resource "google_cloudfunctions_function" "function" {
  provider = google
  project = var.project_id
  region = var.region

  name = "${var.base_app_name}-${var.promotion_level}-trigger-on-http"
  
  runtime = "go116"
  entry_point = "HealthHandler"
  source_archive_bucket = google_storage_bucket.test_app_gcs_repo.name
  source_archive_object = google_storage_bucket_object.source_zip.name

  environment_variables = {
    POSTGRESQL_HOST = var.pgsql_host,
    POSTGRESQL_PASSWORD = "postgres"
  }

  ingress_settings = "ALLOW_ALL"
  vpc_connector = google_vpc_access_connector.connector.id
  trigger_http = true
}

