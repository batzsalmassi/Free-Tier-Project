resource "aws_iam_group" "s3_admins_group" {
  name = var.s3_admins_group
}

resource "aws_iam_group_policy" "s3_admin_policy" {
  name   = "S3AdminPolicy"
  group  = aws_iam_group.s3_admins_group.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_group" "ec2_admins_group" {
  name = var.ec2_admins_group
}

resource "aws_iam_group_policy_attachment" "ec2_admin_policy_attachment" {
  group      = aws_iam_group.ec2_admins_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_group" "global_admins_group" {
  name = var.global_admins_group
}

resource "aws_iam_group_policy" "global_admin_policy" {
  name   = "GlobalAdminPolicy"
  group  = aws_iam_group.global_admins_group.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user" "s3_admin_user" {
  name = var.s3_admin_user
}

resource "aws_iam_user_login_profile" "s3_admin_login_profile" {
  user = aws_iam_user.s3_admin_user.name
  password_reset_required = false
}

resource "aws_iam_user_group_membership" "s3_admin_user_group" {
  user = aws_iam_user.s3_admin_user.name
  groups = [aws_iam_group.s3_admins_group.name]
}

resource "aws_iam_user_policy" "s3_admin_user_policy" {
  name   = "S3UserPolicy"
  user   = aws_iam_user.s3_admin_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["s3:*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user" "ec2_admin_user" {
  name = var.ec2_admin_user
}

resource "aws_iam_user_login_profile" "ec2_admin_login_profile" {
  user = aws_iam_user.ec2_admin_user.name
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "ec2_admin_user_group" {
  user = aws_iam_user.ec2_admin_user.name
  groups = [aws_iam_group.ec2_admins_group.name]
}

resource "aws_iam_user_policy" "ec2_admin_user_policy" {
  name   = "EC2UserPolicy"
  user   = aws_iam_user.ec2_admin_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["ec2:*"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_user" "global_admin_user" {
  name = var.global_admin_user
}

resource "aws_iam_user_login_profile" "global_admin_login_profile" {
  user = aws_iam_user.global_admin_user.name
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "global_admin_user_group" {
  user = aws_iam_user.global_admin_user.name
  groups = [aws_iam_group.global_admins_group.name]
}

resource "aws_iam_user_policy" "global_admin_user_policy" {
  name   = "GlobalUserPolicy"
  user   = aws_iam_user.global_admin_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "PublicInstance1Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_role_policy" {
  name   = "DockerAutomator"
  role   = aws_iam_role.ec2_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "cloudwatch:*",
          "logs:*",
          "s3:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "PublicInstanceProfile1"
  role = aws_iam_role.ec2_role.name
}
