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

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default     = 2
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

variable "os" {
  description = "OS for instance 1"
  type        = string
  default     = "AmazonLinux"
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable s3_bucket {
  description = "S3 bucket for user data files"
  type        = string
}

variable "ec2_public_1_user_data_path" {
  description = "Path to the user data file for EC2 instance 1"
  type        = string
}

variable instance_type {
  description = "The instance type"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "The desired capacity of the group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "The maximum size of the group"
  type        = number
  default     = 4
}

variable "min_size" {
  description = "The minimum size of the group"
  type        = number
  default     = 1
}

variable "docker_token" {
  description = "Docker token"
  type        = string
}

variable "docker_username" {
  description = "Docker username"
  type        = string
}