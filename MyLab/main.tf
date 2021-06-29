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
