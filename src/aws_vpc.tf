resource "aws_vpc" "main" {
  cidr_block = var.cidbr_block

  tags = local.tags
}