#!/bin/bash

# Redirect all output to a log file
exec > /var/log/user-data.log 2>&1

echo "Updating system"
yum update -y

echo "Installing Docker"
yum install -y docker

echo "Installing AWS CLI"
amazon-linux-extras install -y awscli

echo "Starting Docker"
systemctl start docker
systemctl enable docker

echo "Adding ec2-user to Docker group"
usermod -aG docker ec2-user

# Set up directory structure
echo "Setting up directory structure"
mkdir -p /home/ec2-user/app/html/css

# Download files into the proper directory
echo "Downloading index.html from S3"
aws s3 cp s3://${s3_bucket}/webpage2/index.html /home/ec2-user/app/html/index.html

echo "Downloading styles.css from S3"
aws s3 cp s3://${s3_bucket}/webpage2/css/styles.css /home/ec2-user/app/html/css/styles.css

# Create Dockerfile
echo "Creating Dockerfile"
cat <<'EOF' > /home/ec2-user/app/Dockerfile
FROM public.ecr.aws/amazonlinux/amazonlinux:latest
RUN yum update -y && yum install -y httpd
RUN mkdir -p /var/www/html/css
COPY html/index.html /var/www/html/index.html
COPY html/css/styles.css /var/www/html/css/styles.css
RUN echo 'mkdir -p /var/run/httpd' >> /root/run_apache.sh
RUN echo 'mkdir -p /var/lock/httpd' >> /root/run_apache.sh
RUN echo '/usr/sbin/httpd -D FOREGROUND' >> /root/run_apache.sh
RUN chmod 755 /root/run_apache.sh
EXPOSE 80
CMD /root/run_apache.sh
EOF

# Navigate to the app directory, build and run the Docker container
echo "Navigating to app directory"
cd /home/ec2-user/app

echo "Building Docker image"
docker build -t webinterface1 .

echo "Running Docker container"
docker run -d -p 80:80 --restart unless-stopped webinterface1

echo "User data script completed"
