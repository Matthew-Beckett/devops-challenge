include "env" {
    path = "${get_terragrunt_dir()}/../../../_env/postgresql.hcl"
    expose = true
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
            network = {
                network = {
                    id = "projects/mock/global/networks/mock"
                }
            },
    }
}

dependency "vpc_peer" {
    config_path = "${get_terragrunt_dir()}/../vpc_peer"
    mock_outputs = {
        google_compute_global_address_name = "mock-compute-gan"
    }
}

inputs = merge(
    local.level_config.inputs,
    {
       name = "faceit-test-app-pgsql-${local.level_config.inputs.promotion_level}-${local.level_config.inputs.region}",
       zone = local.level_config.inputs.default_zone
       ip_configuration = {
            require_ssl = false
            ipv4_enabled = false
            authorized_networks = []
            private_network = dependency.vpc.outputs.network.network.id
            allocated_ip_range = dependency.vpc_peer.outputs.google_compute_global_address_name
        }
    }
)