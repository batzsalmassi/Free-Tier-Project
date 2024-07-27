#!/bin/bash
yum update -y
yum install -y docker
amazon-linux-extras install -y awscli
systemctl start docker
systemctl enable docker
yum install -y epel-release
yum install stress -y
usermod -aG docker ec2-user
docker login -u ${docker_username} -p ${docker_token}
docker pull ${docker_username}/webinterface1:latest
docker run -d -p 80:80 --restart unless-stopped ${docker_username}/webinterface1