resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_map[var.os]
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  availability_zone           = var.availability_zone
  
  user_data = var.user_data != "" ? templatefile("${path.module}/user_data.sh", { s3_bucket = var.s3_bucket }) : null
  
  tags = {
    Name = "${var.os}-${var.subnet_id}-${var.availability_zone}-Instance"
  }
}


