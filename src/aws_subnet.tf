resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Public A"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Public B"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.6.0/23"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "Private A"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.4.0/23"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "Private B"
  }
}
