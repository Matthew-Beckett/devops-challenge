locals {
    config = read_terragrunt_config(find_in_parent_folders("root.hcl"))
}

inputs = merge(
    local.config.inputs,
    {
        region = "europe-west1"
        default_zone = "europe-west1-b"
    }
)
