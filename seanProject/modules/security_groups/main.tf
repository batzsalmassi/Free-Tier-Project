resource "aws_security_group" "this" {
  vpc_id = var.vpc_id  # The ID of the VPC where the security group will be created
  name   = var.name    # The name of the security group

  dynamic "ingress" {
    for_each = var.ingress_rules  # Iterate over the ingress_rules variable
    content {
      from_port   = ingress.value["from_port"]   # The starting port of the ingress rule
      to_port     = ingress.value["to_port"]     # The ending port of the ingress rule
      protocol    = ingress.value["protocol"]    # The protocol of the ingress rule (e.g., TCP, UDP)
      cidr_blocks = ingress.value["cidr_blocks"] # The CIDR blocks allowed by the ingress rule
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules  # Iterate over the egress_rules variable
    content {
      from_port   = egress.value["from_port"]   # The starting port of the egress rule
      to_port     = egress.value["to_port"]     # The ending port of the egress rule
      protocol    = egress.value["protocol"]    # The protocol of the egress rule (e.g., TCP, UDP)
      cidr_blocks = egress.value["cidr_blocks"] # The CIDR blocks allowed by the egress rule
    }
  }

  tags = var.tags  # The tags to assign to the security group
}