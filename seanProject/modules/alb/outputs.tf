output "lb_arn" {
  value = aws_alb.alb.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.lb_target_group.arn
}

output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "web_server_sg_id" {
  value = var.instance_security_group_id
}
