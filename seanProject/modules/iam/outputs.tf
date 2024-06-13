output "s3_admin_user" {
  description = "The name of the S3 Admin user"
  value       = aws_iam_user.s3_admin_user.name
}

output "ec2_admin_user" {
  description = "The name of the EC2 Admin user"
  value       = aws_iam_user.ec2_admin_user.name
}

output "global_admin_user" {
  description = "The name of the Global Admin user"
  value       = aws_iam_user.global_admin_user.name
}

output "s3_admins_group" {
  description = "The name of the S3 Admins Group"
  value       = aws_iam_group.s3_admins_group.name
}

output "ec2_admins_group" {
  description = "The name of the EC2 Admins Group"
  value       = aws_iam_group.ec2_admins_group.name
}

output "global_admins_group" {
  description = "The name of the Global Admins Group"
  value       = aws_iam_group.global_admins_group.name
}

output "ec2_role" {
  description = "The name of the IAM Role for assume role for EC2"
  value       = aws_iam_role.ec2_role.name
}

output "ec2_instance_profile" {
  description = "The name of the Instance 1 Profile for EC2"
  value       = aws_iam_instance_profile.ec2_instance_profile.name
}