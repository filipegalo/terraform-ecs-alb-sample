data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "terraform_remote_state" "resources" {
  for_each = toset(["vpc", "alb", "rds"])

  backend = "s3"
  config = {
    bucket = var.terraform_remote_state_bucket
    key    = "${var.env}/${var.region}/${each.key}/terraform.tfstate"
  }
}
