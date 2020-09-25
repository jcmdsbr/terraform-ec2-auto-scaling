terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = var.aws_credentials_file
  profile                 = var.aws_profile
}

locals {

  tags = {
    Name = "Terraform"
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.cidbr_block

  tags = local.tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = local.tags

}

# resource  "aws_subnet" "main" {
#   vpc_id = aws_vpc.main.vpc_id
#   cidbr_block = var.cidbr_block

# }