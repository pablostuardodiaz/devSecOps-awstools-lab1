provider "aws" {
    region = "us-east-1"
}

data "aws_iam_policy" "ec2_full_access" {
    arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_security_group" "sg_devsecops_awstools_lab1" {
    name        = "sg_devsecops_awstools_lab1"
    description = "Allow inbound HTTP and HTTPS traffic"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "EC2_devsecops_awstools_lab1web" {
    ami           = "ami-04681163a08179f28"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.sg_devsecops_awstools_lab1.name]

    tags = {
        Name = "devsecops-awstools-lab1-web-server"
    }
}