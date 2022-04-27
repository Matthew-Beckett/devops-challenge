## Applying Terragrunt Configuration
---

In order to apply Terragrunt configuration you must first install Terragrunt which can be acquired from GruntWork's website: https://terragrunt.gruntwork.io/docs/getting-started/install/

Once installed it will utilise whichever version of Terraform is currently in path, if you're utilising TFENV which is highly recommended upon Terragrunt Apply TFENV should hook and switch to the version denoted in .terraform-version.

### Applying all modules at once

Terragrunt can be applied at a multitude of levels depending on the granularity of the change made and amount of resources in scope for change, for example. You can navigate to `infra/europe-west1` and invoke `terragrunt run-all apply` and it will apply every environment stage within that region. Likewise, if you were to navigate further down to just the environment stage you could also invoke `terragrunt run-all apply` there to apply all modules within dev.

Terragrunt will always recursively discover `terragrunt.hcl` files within the current path when `terragrunt run-all apply` is ran.

### Applying a single Terragrunt module

Simply navigate to the directory of the component you'd like to apply, for example `infra/europe-west1/dev/postgresql/terragrunt.hcl` and simply run `terragrunt apply`

