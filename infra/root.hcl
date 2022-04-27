remote_state {
    backend = "gcs"
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite"
    }
    config = {
        project = local.project_id
        bucket         = "faceit-test-app-terraform-state"
        prefix           = "${path_relative_to_include()}/terraform.tfstate"
    }
}

locals {
    project_id = "faceit-test-app"
}

inputs = {
    project_id = local.project_id
    base_app_name = "faceit-test-app"
}