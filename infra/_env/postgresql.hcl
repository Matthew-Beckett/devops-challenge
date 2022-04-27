terraform {
  # On master until https://github.com/terraform-google-modules/terraform-google-sql-db/pull/295 is merged
  # I went to fix this upstream but it was already resolved just pending release.
  source  = "github.com/terraform-google-modules/terraform-google-sql-db//modules/postgresql?ref=master"
}

inputs = {
    name = "faceit-test-app-postgres-default"
    db_name = "postgresql"
    user_name = "postgres"
    user_password = "postgres"
    zone = "europe-west2-a"
    region = "europe-west2"
    database_version = "POSTGRES_13"
}