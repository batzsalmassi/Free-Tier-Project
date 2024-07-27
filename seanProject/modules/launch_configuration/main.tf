data "aws_ami" "latest_amazon_linux" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }

    filter {
        name = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_launch_configuration" "web-server-lc" {
    name_prefix = "web-server-lc-"
    image_id = data.aws_ami.latest_amazon_linux.id
    instance_type = var.instance_type
    key_name = var.key_name
    iam_instance_profile = var.iam_instance_profile
    security_groups = var.security_group_ids
    user_data_base64     = base64encode(templatefile("${path.module}/user_data.sh", { docker_token = var.docker_token , docker_username = var.docker_username }))
    
    lifecycle {
        create_before_destroy = true
    }
}