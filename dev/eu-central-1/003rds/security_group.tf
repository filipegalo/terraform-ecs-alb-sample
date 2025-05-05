module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.project_name}-rds-sg-${var.env}"
  description = "PostgreSQL security group for ${var.project_name} in ${var.env}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_rules       = ["postgresql-tcp"]
  ingress_cidr_blocks = [for subnet in data.aws_subnet.private : subnet.cidr_block]

  tags = var.tags
}
