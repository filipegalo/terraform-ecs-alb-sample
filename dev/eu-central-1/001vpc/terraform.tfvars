# Project Specific
project_name = "dummy-app"
env          = "dev"

tags = {
  project = "dummy-app"
  env     = "dev"
  folder  = "vpc"
}

# Folder Specific
vpc_cidr           = "10.0.0.0/16"
number_of_azs      = 3
enable_nat_gateway = true
single_nat_gateway = true
