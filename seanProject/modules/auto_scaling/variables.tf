variable "vpc_id" {
    description = "The VPC ID"
    type        = string
}

variable "subnet_ids" {
    description = "Subnet ID for the EC2 instance"
    type        = list(string)
}

variable "lunch_configuration_id" {
    description = "The launch configuration ID"
    type        = string
}

variable "target_group_arn" {
    description = "The target group ARN"
    type        = string
}

variable "desired_capacity" {
    description = "Desired capacity of the Auto Scaling group"
    type        = number
    default     = 2
}

variable "max_size" {
    description = "Maximum size of the Auto Scaling group"
    type        = number
    default     = 4
}

variable "min_size" {
    description = "The minimum size of the Auto Scaling group"
    type        = number
    default = 1
}