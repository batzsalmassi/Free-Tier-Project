variable "aws_region" {
  description = "AWS region"  # Description of the variable
  type        = string        # Type of the variable
  default     = "us-east-1"   # Default value for the variable
}

variable "name" {
  description = "Name of the VPC"  # Description of the variable
  type        = string            # Type of the variable
  default     = "main-VPC"        # Default value for the variable
}

variable "cidr" {
  description = "CIDR block for the VPC"  # Description of the variable
  type        = string                    # Type of the variable
  default     = "10.0.0.0/16"             # Default value for the variable
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"  # Description of the variable
  type        = bool                            # Type of the variable
  default     = true                            # Default value for the variable
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"  # Description of the variable
  type        = bool                              # Type of the variable
  default     = true                              # Default value for the variable
}

variable "tags" {
  description = "Tags to apply to resources"  # Description of the variable
  type        = map(string)                    # Type of the variable
  default     = {}                             # Default value for the variable
}

variable "ec2_admin_user" {
  description = "EC2 admin username"  # Description of the variable
  type = string                        # Type of the variable
}

variable "s3_admin_user" {
  description = "S3 Admin username"  # Description of the variable
  type = string                      # Type of the variable
}

variable "global_admin_user" {
  description = "Global Admin username"  # Description of the variable
  type = string                          # Type of the variable
}

variable "ec2_admins_group" {
  description = "ec2 admins group"  # Description of the variable
  type = string                     # Type of the variable
}

variable "s3_admins_group" {
  description = "s3 admins group"  # Description of the variable
  type = string                    # Type of the variable
}

variable "global_admins_group" {
  description = "global admins group"  # Description of the variable
  type = string                        # Type of the variable
}

variable "s3_admin_pass" {
  description = "s3 admin pass"  # Description of the variable
  type = string                  # Type of the variable
}

variable "ec2_admin_pass" {
  description = "ec2 admin pass"  # Description of the variable
  type = string                   # Type of the variable
}

variable "global_admin_pass" {
  description = "global admin pass"  # Description of the variable
  type = string                      # Type of the variable
}
