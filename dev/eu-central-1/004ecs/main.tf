module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "5.12.1"

  cluster_name = "${var.project_name}-ecs-${var.env}"

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  services = {
    dummy-app = {
      cpu    = var.total_cpu
      memory = var.total_memory

      container_definitions = {
        dummy-app = {
          cpu       = var.cpu
          memory    = var.memory
          essential = true
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.image_name}:${var.image_tag}"
          command   = ["python3", "app.py"]

          port_mappings = [
            {
              name          = "dummy-app"
              containerPort = var.port
              protocol      = "tcp"
            }
          ]

          dependencies = [{
            containerName = "dummy-app-init"
            condition     = "COMPLETE"
          }]

          environment = [
            for k, v in merge(var.environment, {
              DB_HOST = data.terraform_remote_state.resources["rds"].outputs.db_instance_address
              DB_USER = data.terraform_remote_state.resources["rds"].outputs.db_instance_username
              DB_NAME = data.terraform_remote_state.resources["rds"].outputs.db_instance_name
              }) : {
              name  = k
              value = v
            }
          ]

          secrets = [
            {
              name      = "DB_PASSWORD"
              valueFrom = "${data.terraform_remote_state.resources["rds"].outputs.db_instance_master_user_secret_arn}:password::"
            },
          ]
        }

        dummy-app-init = {
          cpu       = var.cpu
          memory    = var.memory
          image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/${var.image_name}:${var.image_tag}"
          command   = ["flask", "db", "upgrade"]
          essential = false

          environment = [
            for k, v in merge(var.environment, {
              DB_HOST = data.terraform_remote_state.resources["rds"].outputs.db_instance_address
              DB_USER = data.terraform_remote_state.resources["rds"].outputs.db_instance_username
              DB_NAME = data.terraform_remote_state.resources["rds"].outputs.db_instance_name
              }) : {
              name  = k
              value = v
            }
          ]

          secrets = [
            {
              name      = "DB_PASSWORD"
              valueFrom = "${data.terraform_remote_state.resources["rds"].outputs.db_instance_master_user_secret_arn}:password::"
            },
          ]
        }
      }

      load_balancer = {
        service = {
          target_group_arn = data.terraform_remote_state.resources["alb"].outputs.target_group_api
          container_name   = "dummy-app"
          container_port   = var.port
        }
      }

      subnet_ids = data.terraform_remote_state.resources["vpc"].outputs.private_subnets

      security_group_rules = {
        alb_ingress = {
          type                     = "ingress"
          from_port                = var.port
          to_port                  = var.port
          protocol                 = "tcp"
          description              = "Allow traffic from ALB on port ${var.port}"
          source_security_group_id = data.terraform_remote_state.resources["alb"].outputs.security_group_id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }

      enable_autoscaling = false
    }
  }

  tags = var.tags
}
