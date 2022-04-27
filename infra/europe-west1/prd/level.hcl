locals {
    config = read_terragrunt_config(find_in_parent_folders("region.hcl"))
}

inputs = merge(
    local.config.inputs,
    {
        promotion_level = "prd"
    }
)
