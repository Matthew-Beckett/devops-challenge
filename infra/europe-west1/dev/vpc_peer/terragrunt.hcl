terraform {
  source  = "tfr:///GoogleCloudPlatform/sql-db/google//modules/private_service_access?version=8.0.0"
}

locals {
    level_config = read_terragrunt_config(find_in_parent_folders("level.hcl"))
}

include "root" {
    path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
    config_path = "${get_terragrunt_dir()}/../vpc"
    mock_outputs = {
        network_name = "mock-network-name"
    }
}

inputs = merge(
    local.level_config.inputs,
    {
        vpc_network = dependency.vpc.outputs.network_name
    }
)