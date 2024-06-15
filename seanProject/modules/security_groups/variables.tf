variable "vpc_id" {
  description = "ID of the VPC"  # Description of the variable
  type        = string  # Type of the variable
}

variable "name" {
  description = "Name of the Security Group"  # Description of the variable
  type        = string  # Type of the variable
}

variable "ingress_rules" {
  description = "List of ingress rules"  # Description of the variable
  type = list(object({  # Type of the variable (list of objects)
    from_port   = number  # Type of the object property
    to_port     = number  # Type of the object property
    protocol    = string  # Type of the object property
    cidr_blocks = list(string)  # Type of the object property (list of strings)
  }))
}

variable "egress_rules" {
  description = "List of egress rules"  # Description of the variable
  type = list(object({  # Type of the variable (list of objects)
    from_port   = number  # Type of the object property
    to_port     = number  # Type of the object property
    protocol    = string  # Type of the object property
    cidr_blocks = list(string)  # Type of the object property (list of strings)
  }))
}

variable "tags" {
  description = "Tags for the security group"  # Description of the variable
  type        = map(string)  # Type of the variable (map of strings)
}
