output "security_group_id" {
  value = module.alb.security_group_id
}

output "target_group_api" {
  value = module.alb.target_groups["api"].arn
}
