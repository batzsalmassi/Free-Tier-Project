output "s3_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}

output "ec2_connect_endpoint_id" {
  value = aws_ec2_instance_connect_endpoint.ec2_connect.id
}