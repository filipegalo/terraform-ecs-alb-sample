data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.terraform_remote_state_bucket
    key    = "${var.env}/${var.region}/vpc/terraform.tfstate"
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.terraform_remote_state.vpc.outputs.private_subnets)
  id       = each.value
}
