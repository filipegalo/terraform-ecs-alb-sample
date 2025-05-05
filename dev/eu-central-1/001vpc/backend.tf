terraform {

  backend "s3" {
    encrypt = true
    bucket  = "tf-dummy-app-state"
    key     = "dev/eu-central-1/vpc/terraform.tfstate"
    region  = "eu-central-1"
  }
}
