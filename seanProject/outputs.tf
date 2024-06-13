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
  value = module.security_groups.public_security_group_id
}

output "private_security_group" {
  value = module.security_groups.private_security_group_id
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


