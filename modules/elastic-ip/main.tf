resource "aws_eip" "aws_assignment_eip" {
  domain = "vpc"

  tags = {
    Name = var.name
  }
}

resource "aws_eip_association" "aws_assignment_eip" {
  allocation_id = aws_eip.aws_assignment_eip.id
  instance_id   = var.instance_id
}