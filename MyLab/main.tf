terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.0"
        }
    }
}

# Configuring the AWS provider
provider "aws" {
    region = "ap-south-1"
}

# Create a VPC
resource "aws_vpc" "MyLab-VPC" {
    cidr_block = var.cidr_block[0]
    tags = {
        Name = "MyLab_VPC"
    }
}

# Create Subnet (public)
resource "aws_subnet" "MyLab-Subnet1" {
    vpc_id = aws_vpc.MyLab-VPC.id
    cidr_block = var.cidr_block[1]
    tags = {
        Name = "MyLab-Subnet1"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "MyLab-IntGW" {
    vpc_id =   aws_vpc.MyLab-VPC.id
    tags = {
        Name = "MyLab-IntGW"
    }
}

# Create Security Group
resource "aws_security_group" "MyLab-Sec-Grp" {
    name = "MyLab Security Group"
    description = "Allow inboud and outbound traffic to MyLab"
    vpc_id = aws_vpc.MyLab-VPC.id

    dynamic ingress {
        iterator = port
        for_each = var.ports
            content{
                from_port = port.value
                to_port = port.value
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "MyLab-SG1"
    }    
  
}
