terraform {

  backend "s3" {
    encrypt = true
    bucket  = "tf-dummy-app-state"
    key     = "global/eu-central-1/iam/terraform.tfstate"
    region  = "eu-central-1"
  }
}
