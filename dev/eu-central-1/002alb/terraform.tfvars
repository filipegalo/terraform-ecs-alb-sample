# Project Specific
project_name = "dummy-app"
env          = "dev"
region       = "eu-central-1"

terraform_remote_state_bucket = "tf-dummy-app-state"

tags = {
  project = "dummy-app"
  env     = "dev"
  folder  = "alb"
}

# Folder Specific
service_port              = 8000
service_health_check_path = "/api/health"
