variable "s3_admin_user" {
  description = "The name of the S3 Admin user"
  type        = string
}

variable "s3_admin_pass" {
  description = "The password for the S3 Admin user"
  type        = string
  sensitive   = true
}

variable "ec2_admin_user" {
  description = "The name of the EC2 Admin user"
  type        = string
}

variable "ec2_admin_pass" {
  description = "The password for the EC2 Admin user"
  type        = string
  sensitive   = true
}

variable "global_admin_user" {
  description = "The name of the Global Admin user"
  type        = string
}

variable "s3_admins_group" {
  description = "The name of the S3 Admins Group"
  type        = string
}

variable "ec2_admins_group" {
  description = "The name of the EC2 Admins Group"
  type        = string
}

variable "global_admins_group" {
  description = "The name of the Global Admins Group"
  type        = string
}

variable "global_admin_pass" {
    description = "global admin user pass"
    type      = string
}