output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_1" {
  value = module.vpc.public_subnet_ids[0]
}

output "public_subnet_2" {
  value = module.vpc.public_subnet_ids[1]
}

output "private_subnet_1" {
  value = module.vpc.private_subnet_ids[0]
}

output "private_subnet_2" {
  value = module.vpc.private_subnet_ids[1]
}

output "public_security_group" {
  value = module.security_group_public.security_group_id
}

output "private_security_group" {
  value = module.security_group_private.security_group_id
}

output "availability_zone_1" {
  value = data.aws_availability_zones.available.names[0]
}

output "availability_zone_2" {
  value = data.aws_availability_zones.available.names[1]
}

output "s3_endpoint" {
  value = module.endpoints.s3_endpoint_id
}

output "ec2_endpoint" {
  value = module.endpoints.ec2_connect_endpoint_id
}

output "ec2_role" {
  value = module.iam.ec2_role_arn
}

output "ec2_instance_profile" {
  value = module.iam.ec2_instance_profile
}

output "s3_admin_user" {
  value = module.iam.s3_admin_user
}

output "ec2_admin_user" {
  value = module.iam.ec2_admin_user
}

output "global_admin_user" {
  value = module.iam.global_admin_user
}

output "s3_admins_group" {
  value = module.iam.s3_admins_group
}

output "ec2_admins_group" {
  value = module.iam.ec2_admins_group
}

output "global_admins_group" {
  value = module.iam.global_admins_group
}

output "public-route-table" {
  value = module.vpc.public_route_table_id
}

output "private-route-table" {
  value = module.vpc.private_route_table_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}
