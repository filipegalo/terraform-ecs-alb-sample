# Project Specific
project_name = "dummy-app"
env          = "dev"
region       = "eu-central-1"

terraform_remote_state_bucket = "tf-dummy-app-state"

tags = {
  project = "dummy-app"
  env     = "dev"
  folder  = "ecs"
}

# Folder Specific
image_name   = "dummy-app"
image_tag    = "latest"
total_cpu    = 1024
total_memory = 2048
cpu          = 512
memory       = 1024
port         = 8000

environment = {
  ENVIRONMENT      = "dev"
  ENVIRONMENT_TYPE = "cloud"
  SECRET_KEY       = "dummy-app-secret-key"
}
