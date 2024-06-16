variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the EC2 instance"
  type        = string
}

variable "ami_map" {
  description = "Mapping of OS to AMI"
  type        = map(string)
  default = {
    Ubuntu       = "ami-080e1f13689e07408",
    AmazonLinux  = "ami-08a0d1e16fc3f61ea",
    Windows      = "ami-0f496107db66676ff",
    RedHat       = "ami-0fe630eb857a6ec83"
  }
}

variable "os" {
  description = "Operating System"
  type        = string
  default     = "AmazonLinux"
}

variable "key_name" {
  description = "Key pair name"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the instance"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket for user data files"
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}
