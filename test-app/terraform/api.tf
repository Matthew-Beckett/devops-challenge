resource "google_project_service" "cloudfunctions_api" {
  provider = google-beta
  project = var.project_id

  service  = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudrun_api" {
  provider = google-beta
  project = var.project_id

  service  = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifactregistry_api" {
  provider = google-beta
  project = var.project_id

  service  = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild_api" {
  provider = google-beta
  project = var.project_id

  service  = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}