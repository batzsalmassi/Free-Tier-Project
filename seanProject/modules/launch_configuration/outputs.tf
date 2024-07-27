output "launch_configuration_id" {
  value = aws_launch_configuration.web-server-lc.id
}

output "docker_username" {
  value = var.docker_username
}