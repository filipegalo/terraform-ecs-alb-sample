# Project Specific
project_name = "dummy-app"
env          = "dev"
region       = "eu-central-1"

terraform_remote_state_bucket = "tf-dummy-app-state"

tags = {
  project = "dummy-app"
  env     = "dev"
  folder  = "rds"
}

# Folder Specific
rds_engine_version    = "17.4"
family                = "postgres17"
major_engine_version  = "17"
instance_class        = "db.t4g.micro"
allocated_storage     = 10
max_allocated_storage = 20
multi_az              = "false"
username              = "app_db_user"
db_name               = "app_db"
