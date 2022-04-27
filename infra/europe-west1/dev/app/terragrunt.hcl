include "env" {
    path = "${get_terragrunt_dir()}/../../../_env/app.hcl"
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
            network_name = "mock-network-name"
    }
}

dependency "postgresql" {
    config_path = "${get_terragrunt_dir()}/../postgresql"
        mock_outputs = {
            private_ip_address = "127.0.0.1"
    }
}


inputs = merge(
    local.level_config.inputs,
    {
        vpc_connector_vpc_name = dependency.vpc.outputs.network_name
        vpc_connector_ip_cidr_range = "10.13.0.0/28"
        source_path = "${get_terragrunt_dir()}/../../../../test-app"
        pgsql_host = dependency.postgresql.outputs.private_ip_address
    }
)