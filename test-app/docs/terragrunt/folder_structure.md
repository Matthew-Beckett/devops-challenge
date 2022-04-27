## Terragrunt Folder Structure Explained
---

This project utilises Terragrunt to allow for DRY configuration of all Terraform resources across environments and stages as documented in the following guides from GruntWork

- https://terragrunt.gruntwork.io/docs/features/keep-your-terraform-code-dry/
- https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/
- https://terragrunt.gruntwork.io/docs/features/keep-your-terragrunt-architecture-dry/


## Folder Structure

```
.
├── README.md
├── infra
│   ├── _env
│   │   ├── app.hcl
│   │   ├── postgresql.hcl
│   │   └── vpc.hcl
│   ├── europe-west1
│   │   ├── dev
│   │   │   ├── app
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── postgresql
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── vpc
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── vpc_peer
│   │   │   │   └── terragrunt.hcl
│   │   │   └── level.hcl
│   │   ├── prd
│   │   │   ├── app
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── postgresql
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── vpc
│   │   │   │   └── terragrunt.hcl
│   │   │   ├── vpc_peer
│   │   │   │   └── terragrunt.hcl
│   │   │   └── level.hcl
│   │   └── region.hcl
│   └── root.hcl
└── test-app
    ├── README.md
    ├── docs
    │   ├── infrastructure
    │   ├── terraform
    │   └── terragrunt
    │       └── folder_structure.md
    ├── function.go
    ├── go.mod
    ├── go.sum
    └── terraform
        ├── api.tf
        ├── iam.tf
        ├── main.tf
        ├── outputs.tf
        ├── variables.tf
        └── vpc_access.tf
```

### infra/_env - Common DRY Templates

This directory contains Terragrunt files which invoke upstream (or downsteam) modules from Cloud Providers such as GCP and hydrates them with sane defaults to prevent repetition of values which can be set once consistently for all environments such as common booleans.

### infra/europe-west1 - Region Level Directory

At this level only a single file is present named `region.hcl`, this file is exclusively responsible for including any region specific values, these can include but are not limited to values such as default availability zone allocations, default tags, and common IAM policy IDs for use by multiple modules.

### infra/europe-west-1/dev - Promotion Level Directory

Much like the region level directory, this file also only contains a single .hcl file named `level.hcl`. This file includes inputs such as the promotion level like "dev" or "prd" for use in resource name templating.

### infra/europe-west-1/dev/app|postgresql|vpc|vpc_peer - Terragrunt defintion for Terraform module

This directory contains the Terragrunt definition to include and deploy the DRY app template from `infra/_env` as well as include any overrides.

For example, `infra/europe-west-1/dev/app` includes `infra/_env/app.hcl` and overrides an assortment of required properties.

