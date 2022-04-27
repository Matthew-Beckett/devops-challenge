## Releasing a new version of FaceIT Test App

The Terragrunt/Terraform is configured in such as way that it is resposible for the packaging and uploading of the source archive object for CloudRun, as a result creating a new release is simple.

Simply make any requred changes, and navigate to `infra/europe-west1/dev/app/terragrunt.hcl` or `infra/europe-west1/prd/app/terragrunt.hcl` depening on environment, make your required changes and then run `terragrunt apply`.

Terragrunt with automatically handle deployment of the latest version and migration of traffic, it will also handle the building in GoogleCloud via CloudBuild.