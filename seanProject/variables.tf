variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "name" {
  description = "Name of the VPC"
  type        = string
  default     = "main-VPC"
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "ec2_admin_user" {
  description = "EC2 admin username"
  type = string
}

variable "s3_admin_user" {
  description = "S3 Admin username"
  type = string
}

variable "global_admin_user" {
  description = "Global Admin username"
  type = string
}

variable "ec2_admins_group" {
  description = "ec2 admins group"
  type = string
}

variable "s3_admins_group" {
  description = "s3 admins group"
  type = string
}

variable "global_admins_group" {
  description = "global admins group"
  type = string
}

variable "s3_admin_pass" {
  description = "s3 admin pass"
  type = string
}

variable "ec2_admin_pass" {
  description = "ec2 admin pass"
  type = string
}

variable "global_admin_pass" {
  description = "global admin pass"
  type = string
}

