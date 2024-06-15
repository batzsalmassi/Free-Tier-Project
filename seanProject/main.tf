provider "aws" {
  region = var.aws_region  # Specify the AWS region to use
}

data "aws_availability_zones" "available" {}  # Retrieve the available availability zones in the specified region

module "vpc" {
  source = "./modules/vpc"  # Use the VPC module located in the "./modules/vpc" directory

  name                 = var.name  # Set the name of the VPC
  cidr                 = var.cidr  # Set the CIDR block for the VPC
  enable_dns_support   = var.enable_dns_support  # Enable DNS support for the VPC
  enable_dns_hostnames = var.enable_dns_hostnames  # Enable DNS hostnames for the VPC
  tags                 = var.tags  # Set tags for the VPC
}

module "security_group_public" {
  source = "./modules/security_groups"  # Use the security groups module located in the "./modules/security_groups" directory

  vpc_id = module.vpc.vpc_id  # Use the VPC ID from the VPC module
  name   = "PublicSubnetSecurityGroup"  # Set the name of the security group
  ingress_rules = [  # Define the ingress rules for the security group
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow ICMP (ping) access from any IP
    }
  ]
  egress_rules = [  # Define the egress rules for the security group
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic to any IP
    }
  ]
  tags = {  # Set tags for the security group
    Name = "PublicSubnetSecurityGroup"
  }
}

module "security_group_private" {
  source = "./modules/security_groups"  # Use the security groups module located in the "./modules/security_groups" directory

  vpc_id = module.vpc.vpc_id  # Use the VPC ID from the VPC module
  name   = "PrivateSubnetSecurityGroup"  # Set the name of the security group
  ingress_rules = [  # Define the ingress rules for the security group
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP
    },
    {
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow ICMP (ping) access from any IP
    }
  ]
  egress_rules = [  # Define the egress rules for the security group
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]  # Restrict outbound traffic to the VPC CIDR for internal communication
    }
  ]
  tags = {  # Set tags for the security group
    Name = "PrivateSubnetSecurityGroup"
  }
}

module "endpoints" {
  source = "./modules/endpoints"  # Use the endpoints module located in the "./modules/endpoints" directory

  vpc_id            = module.vpc.vpc_id  # Use the VPC ID from the VPC module
  aws_region        = var.aws_region  # Specify the AWS region
  route_table_ids   = [module.vpc.private_route_table_id]  # Use the private route table ID from the VPC module
  subnet_id         = module.vpc.private_subnet_ids[1]  # Use the second private subnet ID from the VPC module
  security_group_ids = [module.security_group_private.security_group_id]  # Use the security group ID from the private security group module
}

module "iam" {
  source = "./modules/iam"  # Use the IAM module located in the "./modules/iam" directory

  ec2_admin_user = var.ec2_admin_user  # Set the EC2 admin user
  ec2_admins_group = var.ec2_admins_group  # Set the EC2 admins group
  ec2_admin_pass = var.ec2_admin_pass  # Set the EC2 admin password

  global_admin_user = var.global_admin_user  # Set the global admin user
  global_admins_group = var.global_admins_group  # Set the global admins group
  global_admin_pass = var.global_admin_pass  # Set the global admin password

  s3_admin_user = var.s3_admin_user  # Set the S3 admin user
  s3_admins_group = var.s3_admins_group  # Set the S3 admins group
  s3_admin_pass = var.s3_admin_pass  # Set the S3 admin password
}
