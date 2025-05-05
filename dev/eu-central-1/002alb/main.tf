module "alb" {
  source = "terraform-aws-modules/alb/aws"

  name    = "${var.project_name}-alb-${var.env}"
  vpc_id  = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets = data.terraform_remote_state.vpc.outputs.public_subnets

  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
    }
  }

  target_groups = {
    api = {
      name                 = "${var.project_name}-tg-${var.env}"
      backend_protocol     = "HTTP"
      backend_port         = var.service_port
      target_type          = "ip"
      deregistration_delay = 10
      create_attachment    = false
      health_check = {
        enabled             = true
        interval            = 30
        path                = var.service_health_check_path
        port                = var.service_port
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  }

  listeners = {
    ex-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "api"
      }
      rules = {
        api-rule = {
          priority = 1
          actions = [{
            type             = "forward"
            target_group_key = "api"
          }]
          conditions = [{
            path_pattern = {
              values = ["/api/*"]
            }
          }]
        }
      }
    }
  }

  enable_deletion_protection = false

  tags = var.tags
}
