data "aws_availability_zones" "working" {}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "default" {
  filter {
    name   = "tag:Name"
    values = ["3-tier-vpc"]
  }
}

data "aws_subnet" "subnet1" {
  filter {
    name   = "tag:Name"
    values = ["subnet1"]
  }
}

data "aws_subnet" "subnet2" {
  filter {
    name   = "tag:Name"
    values = ["subnet2"]
  }
}

data "aws_vpc" "test" {
  tags = {
    Name = "3-tier-vpc"
  }
}