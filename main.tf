#terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.0"
    }
  }
}

#provider
provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      Name        = "2392829"
      cco_trainee = "2392829@cognizant.com"
    }
  }
}

#vpc block
resource "aws_vpc" "prod_shikhar" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod_shikhar"
  }
}

resource "aws_subnet" "prod_pb_subnet" {
  vpc_id     = aws_vpc.prod_shikhar.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "prod_pb_subnet"
  }
}
#Private subnet

resource "aws_subnet" "prod_pr_subnet" {
  vpc_id     = aws_vpc.prod_shikhar.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "prod_pr_subnet"
  }
}

#internet gateway attach into vpc
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_shikhar.id

  tags = {
    Name = "prod_igw"
  }
}

#for route table we do not have the permission to run using the public subnet and environment. Nor can we create the SG using terraform due to platform restrictions.
#public Route Table
resource "aws_route_table" "prod_pb_rt" {
  vpc_id = aws_vpc.prod_shikhar.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw.id
  }

  tags = {
    Name = "prod_pb_rt"
  }
}
# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat_eip"
  }
}

# NAT Gateway - must live in the PUBLIC subnet
resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.prod_pb_subnet.id

  tags = {
    Name = "prod_nat_gateway"
  }

  depends_on = [aws_internet_gateway.prod_igw]
}

#private Route Table
resource "aws_route_table" "prod_private_rt" {
  vpc_id = aws_vpc.prod_shikhar.id
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT.id
  }
  tags = {
    Name = "prod_private_rt"
  }
}

