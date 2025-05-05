module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"

  identifier = "${var.project_name}-rds-${var.env}"

  engine                = "postgres"
  engine_version        = var.rds_engine_version
  family                = var.family
  major_engine_version  = var.major_engine_version
  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  multi_az = var.multi_az

  create_db_subnet_group = true
  subnet_ids             = data.terraform_remote_state.vpc.outputs.private_subnets

  vpc_security_group_ids      = [module.security_group.security_group_id]
  manage_master_user_password = true
  username                    = var.username
  port                        = 5432

  db_name = var.db_name

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  tags = var.tags

}
