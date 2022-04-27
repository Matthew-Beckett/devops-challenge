resource "google_project_service" "vpcaccess_api" {
  provider = google-beta
  project = var.project_id

  service  = "vpcaccess.googleapis.com"
  disable_on_destroy = false
}

resource "google_vpc_access_connector" "connector" {
  provider      = google-beta
  project = var.project_id
  region = var.region

  name          = "${var.base_app_name}-${var.promotion_level}"
  ip_cidr_range = var.vpc_connector_ip_cidr_range
  network = var.vpc_connector_vpc_name
}
