resource "aws_vpc" "aws_assignment_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.aws_assignment_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.public_availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.name
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.aws_assignment_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_availability_zone

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "aws_assignment_internet_gateway" {
  vpc_id = aws_vpc.aws_assignment_vpc.id

  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.aws_assignment_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws_assignment_internet_gateway.id
  }

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}