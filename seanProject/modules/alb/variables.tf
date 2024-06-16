variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "subnet_ids" {
    description = "Subnet ID for the EC2 instance"
    type        = list(string)
}

variable "alb_name" {
    description = "The name of the load balancer"
    type        = string
    default = "WebServerALB"
}

variable "tg_name" {
    description = "Name of the Target Group"
    type        = string
    default = "WebServerTargetGroup"
}

variable "health_check_path" {
    description = "The health check path"
    type        = string
    default = "/"
}

variable "instance_security_group_id" {
    description = "The security group id for the EC2 instances"
    type        = string
}
