variable "aws_region" {
  type        = string
  description = "describe default region to create a resource from aws"
  default     = "us-east-1"
}

variable "aws_credentials_file" {
  type        = string
  description = "describe a path to locate a credentials from access aws cli"
  default     = "$HOME/.aws/credentials"
}

variable "aws_profile" {
  type        = string
  description = "describe a specifc profile to access a aws cli"
  default     = "terraform"
}

variable "cidbr_block" {
  type    = string
  default = "192.168.0.0/16"
}

variable "aws_private_a_cidr_block" {
  type    = string
  default = "192.168.6.0/23"
}

variable "aws_ami" {
  type    = string
  default = "ami-00514a528eadbc95b"
}

variable "aws_ec2_instance_type" {
  type    = string
  default = "t2.micro"
}