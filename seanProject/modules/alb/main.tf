resource "aws_alb" "alb" {
    name       = var.alb_name
    internal   = false
    load_balancer_type = "application"
    security_groups = [var.instance_security_group_id]
    subnets = var.subnet_ids

    tags = {
        Name = var.alb_name
    }
}

resource "aws_lb_target_group" "lb_target_group" {
    name = var.tg_name
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
        path = var.health_check_path
    }

    tags = {
        Name = var.tg_name
    }
}

resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_alb.alb.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.lb_target_group.arn
    }
}


resource "aws_security_group_rule" "allow_lb_access" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = var.instance_security_group_id
  source_security_group_id = var.instance_security_group_id
}