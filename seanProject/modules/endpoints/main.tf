resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids   = var.route_table_ids
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "S3Endpoint"
  }
}
resource "aws_ec2_instance_connect_endpoint" "ec2_connect" {
  subnet_id = var.subnet_id
  security_group_ids = var.security_group_ids
  preserve_client_ip = false
  tags = {
    Name = "EC2ConnectEndpoint"
  }
}
