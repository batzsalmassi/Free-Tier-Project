variable "instance_type" {
  description = "The instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
    description = "The key pair name"
    type        = string
}

variable "iam_instance_profile" {
    description = "IAM instance profile for the instance"
    type        = string
}

variable "security_group_ids" {
    description = "The security group ids for the instance"
    type        = list(string)
}

variable "s3_bucket" {
    description = "The S3 bucket for user data files"
    type        = string
}

variable "docker_token" {
    description = "The Docker token for the instance"
    type        = string
}

variable "docker_username" {
    description = "The Docker username for the instance"
    type        = string
}