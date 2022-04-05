# main.tf
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 0.12.0"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

### EC2

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
# Create IAM role

resource "aws_iam_role" "ec2_role_node_project" {
  name = "ec2_role_node_project"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    project = "node-project"
  }
}
#Attach the role to an instance profile

resource "aws_iam_instance_profile" "ec2_profile_node_project" {
  name = "ec2_profile_node_project"
  role = aws_iam_role.ec2_role_node_project.name
}

#Attach the role to a policy 

resource "aws_iam_role_policy" "ec2_policy" {
  name = "ec2_policy"
  role = aws_iam_role.ec2_role_node_project.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t3.micro"
  
  user_data = <<-EOF
  #!/bin/bash
    set -ex
    sudo yum update -y
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo yum install git -y
    sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    cd /home/ec2-user    
    sudo su - ec2-user
    touch password
    echo <pwd> > password
    cat ./password | docker login -u <username> --password-stdin 
    git clone https://github.com/LKISTSN/firstproject-repo.git ./NodeProj
    docker pull <username>/docker-repo-flo 
    docker run --name LK1stContainer -p 8080:3000 -d <username>/docker-repo-flo
  EOF

  vpc_security_group_ids = [
    "sg-072b78676719d0765",
    "sg-072b78676719d0765"
  ]
 # Attach instance profile to ec2 instance

  iam_instance_profile = aws_iam_instance_profile.ec2_profile_node_project.name

  tags = {
    project = "node-project"
  }

  monitoring              = true
  disable_api_termination = false
  ebs_optimized           = true
}
