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
