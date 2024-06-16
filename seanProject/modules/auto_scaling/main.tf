resource "aws_autoscaling_group" "web-server-asg" {
    launch_configuration = var.lunch_configuration_id
    vpc_zone_identifier = var.subnet_ids
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size
    target_group_arns = [var.target_group_arn]

    tag {
        key = "Name"
        value = "web-server-asg"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "scale-up" {
    name = "web-server-scale-up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.web-server-asg.name
}

resource "aws_autoscaling_policy" "scale-down" {
    name = "web-server-scale-down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.web-server-asg.name
}

resource "aws_cloudwatch_metric_alarm" "cpu-utilization-high" {
    alarm_name          =  "web-server-cpu-utilization-high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 120
    statistic           = "Average"
    threshold           = 60 #60% CPU utilization
    alarm_description   = "This metric monitors if the CPU utilization of the EC2 instances is greater or equal to 60%"
    alarm_actions       = [aws_autoscaling_policy.scale-up.arn]

    dimensions = {
      autoscaling_group_name = aws_autoscaling_group.web-server-asg.name
    }
}

resource "aws_cloudwatch_metric_alarm" "cpu-utilization-low" {
    alarm_name          =  "web-server-cpu-utilization-low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = 2
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = 120
    statistic           = "Average"
    threshold           = 20 #20% CPU utilization
    alarm_description   = "This metric monitors if the CPU utilization of the EC2 instances is less or equal to 20%"
    alarm_actions       = [aws_autoscaling_policy.scale-down.arn]
    dimensions = {
        autoscaling_group_name = aws_autoscaling_group.web-server-asg.name
    }
}