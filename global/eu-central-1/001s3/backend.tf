terraform {

  backend "s3" {
    encrypt = true
    bucket  = "tf-dummy-app-state"
    key     = "global/eu-central-1/s3/terraform.tfstate"
    region  = "eu-central-1"
  }
}
