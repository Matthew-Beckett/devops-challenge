variable "gcs_source_bucket_name" {
    type = string
    default = "faceit-test-app-source-bucket"
}

variable "gcs_source_bucket_location" {
    type = string
    default = "EU"
}

variable "go_runtime_version" {
    type = string
    default = "go116"
}

variable "promotion_level" {
    type = string
    default = "default"
}

variable "project_id" {
    type = string
}

variable "region" {
    type = string
}

variable "source_path" {
    type = string
}

variable "base_app_name" {
    type = string
    default = "faceit-test-app"
}

variable "vpc_connector_vpc_name" {
    type = string
}

variable "vpc_connector_ip_cidr_range" {
    type = string
}

variable "pgsql_host" {
    type = string
}