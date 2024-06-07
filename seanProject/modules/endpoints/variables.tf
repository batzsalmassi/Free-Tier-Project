variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "route_table_ids" {
  description = "IDs of the route tables"
  type        = list(string)
}

variable "subnet_id" {
  description = "ID of the subnet for the endpoint"
  type        = string
}

variable "security_group_ids" {
  description = "IDs of the security groups"
  type        = list(string)
}

variable "preserve_client_id" {
  description = "Set to true to preserve the client's IP address when establishing an instance connection"
  type        = bool
  default = false
}