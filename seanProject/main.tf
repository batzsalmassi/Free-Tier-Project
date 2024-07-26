provider "aws" {
  region = var.aws_region  # Specify the AWS region to use
}

data "aws_availability_zones" "available" {}  # Retrieve the available availability zones in the specified region

module "vpc" {
  source = "./modules/vpc"

  name                = var.name  # Set the name of the VPC
  cidr                = var.cidr  # Set the CIDR block for the VPC
  enable_dns_support  = true  # Enable DNS support for the VPC
  enable_dns_hostnames = true  # Enable DNS hostnames for the VPC
  public_subnet_count = var.public_subnet_count  # Set the number of public subnets
  private_subnet_count = var.private_subnet_count  # Set the number of private subnets
  tags = var.tags  # Set tags for the VPC module
}

module "security_group_public" {
  source = "./modules/security_groups"  # Use the security groups module located in the "./modules/security_groups" directory

  vpc_id = module.vpc.vpc_id  # Use the VPC ID from the VPC module
  name   = "PublicSubnetSecurityGroup"  # Set the name of the security group

  # Define the ingress rules for the security group
  ingress_rules = [
    {
      from_port   = 22  # Allow SSH access
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP
    },
    {
      from_port   = 80  # Allow HTTP access
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
    },
    {
      from_port   = -1  # Allow ICMP (ping) access
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow ICMP (ping) access from any IP
    }
  ]

  # Define the egress rules for the security group
  egress_rules = [
    {
      from_port   = 0  # Allow all outbound traffic
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

  # Define the ingress rules for the security group
  ingress_rules = [
    {
      from_port   = 80  # Allow HTTP access
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
    },
    {
      from_port   = 22  # Allow SSH access
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP
    },
    {
      from_port   = -1  # Allow ICMP (ping) access
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow ICMP (ping) access from any IP
    }
  ]

  # Define the egress rules for the security group
  egress_rules = [
    {
      from_port   = 0  # Restrict outbound traffic to the VPC CIDR for internal communication
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
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
  subnet_id         = module.vpc.private_subnets[1]  # Use the second private subnet ID from the VPC module
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

module "ec2Insatance1Public" {
  source               = "./modules/ec2"

  vpc_id               = module.vpc.vpc_id
  subnet_id            = element(module.vpc.public_subnets, 1)
  availability_zone    = element(module.vpc.availability_zones, 1)
  os                   = var.os
  key_name             = var.key_name
  iam_instance_profile = module.iam.ec2_instance_profile
  security_group_id    = module.security_group_public.security_group_id
  s3_bucket            = var.s3_bucket
  user_data = base64encode(templatefile("${path.module}/modules/ec2/user_data.sh", { s3_bucket = var.s3_bucket }))
}

module "web_server_sg" {
  source = "./modules/security_groups"  # Use the security groups module located in the "./modules/security_groups" directory

  vpc_id = module.vpc.vpc_id  # Use the VPC ID from the VPC module
  name   = "web-server-security-group"  # Set the name of the security group

  # Define the ingress rules for the security group
  ingress_rules = [
    {
      from_port   = 22  # Allow SSH access
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from any IP
    },
    {
      from_port   = 80  # Allow HTTP access
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from any IP
    },
    {
      from_port   = 443  # Allow HTTPS access
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS access from any IP
    },
    {
      from_port   = 0  # Allow ICMP (ping) access
      to_port     = 0
      protocol    = -1
      cidr_blocks = ["0.0.0.0/0"]  # Allow ICMP (ping) access from any IP
    }
  ]

  # Define the egress rules for the security group
  egress_rules = [
    {
      from_port   = 0  # Allow all outbound traffic
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic to any IP
    }
  ]

  tags = {  # Set tags for the security group
    Name = "web-server-security-group"
  }
}

module "alb" {
  source                     = "./modules/alb"
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.public_subnets
  instance_security_group_id = module.web_server_sg.security_group_id
}

module "launch_configuration" {
  source = "./modules/launch_configuration"

  instance_type = var.instance_type
  key_name = var.key_name
  iam_instance_profile = module.iam.ec2_instance_profile
  security_group_ids = [module.web_server_sg.security_group_id]
  s3_bucket = var.s3_bucket
}

module "autoscaling" {
  source = "./modules/auto_scaling"

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  lunch_configuration_id = module.launch_configuration.launch_configuration_id
  target_group_arn = module.alb.target_group_arn
  desired_capacity = 2
  max_size = 4
  min_size = 1
}