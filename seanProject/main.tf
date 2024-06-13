provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "./modules/vpc"

  name                 = var.name
  cidr                 = var.cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = var.tags
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "endpoints" {
  source = "./modules/endpoints"

  vpc_id            = module.vpc.vpc_id
  aws_region        = var.aws_region
  route_table_ids   = [module.vpc.private_route_table_id]
  subnet_id         = module.vpc.private_subnet_ids[1]
  security_group_ids = [module.security_groups.private_security_group_id]
}

module "iam" {
  source = "./modules/iam"

  ec2_admin_user = var.ec2_admin_user
  ec2_admins_group = var.ec2_admins_group
  ec2_admin_pass = var.ec2_admin_pass

  global_admin_user = var.global_admin_user
  global_admins_group = var.global_admins_group
  global_admin_pass = var.global_admin_pass

  s3_admin_user = var.s3_admin_user
  s3_admins_group = var.s3_admins_group
  s3_admin_pass = var.s3_admin_pass
}
