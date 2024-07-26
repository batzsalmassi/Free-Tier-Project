output "launch_configuration_id" {
  value = aws_launch_configuration.web-server-lc.id
}

output "s3_bucket" {
  value = var.s3_bucket
}