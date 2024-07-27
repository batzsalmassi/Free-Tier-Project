#!/bin/bash
yum update -y
yum install -y docker
amazon-linux-extras install -y awscli
systemctl start docker
systemctl enable docker
yum install -y epel-release
yum install stress -y
usermod -aG docker ec2-user
mkdir -p /home/ec2-user/app/html
aws s3 cp s3://${s3_bucket}/index.html /home/ec2-user/app/html/index.html
aws s3 cp s3://${s3_bucket}/architecture-diagram.png /home/ec2-user/app/html/architecture-diagram.png
cat <<'EOF' > /home/ec2-user/app/Dockerfile
FROM public.ecr.aws/amazonlinux/amazonlinux:latest
RUN yum update -y && yum install -y httpd
COPY html/index.html /var/www/html/index.html
COPY html/architecture-diagram.png /var/www/html/architecture-diagram.png
RUN echo 'mkdir -p /var/run/httpd' >> /root/run_apache.sh
RUN echo 'mkdir -p /var/lock/httpd' >> /root/run_apache.sh
RUN echo '/usr/sbin/httpd -D FOREGROUND' >> /root/run_apache.sh
RUN chmod 755 /root/run_apache.sh
EXPOSE 80
CMD /root/run_apache.sh
EOF
cd /home/ec2-user/app
docker build -t webinterface1 .
docker run -d -p 80:80 --restart unless-stopped webinterface1