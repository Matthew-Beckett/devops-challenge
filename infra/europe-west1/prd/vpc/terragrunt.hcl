include "env" {
    path = "${get_terragrunt_dir()}/../../../_env/vpc.hcl"
    expose = true
}

locals {
    level_config = read_terragrunt_config(find_in_parent_folders("level.hcl"))
}

include "root" {
    path = find_in_parent_folders("root.hcl")
}

inputs = merge(
    local.level_config.inputs,
    {
        network_name = "faceit-test-app-${local.level_config.inputs.promotion_level}",
        subnets = [
            {
                subnet_name           = "faceit-test-app-${local.level_config.inputs.promotion_level}-subnet-01"
                subnet_ip             = "10.10.0.0/28"
                subnet_region         = "europe-west2"
            }
        ]

        secondary_ranges = {
            "faceit-test-app-${local.level_config.inputs.promotion_level}-subnet-01" = [
                {
                    range_name = "faceit-test-app-${local.level_config.inputs.promotion_level}-secondary-01"
                    ip_cidr_range = "10.11.0.0/24"
                }
            ]
        }
    }
)