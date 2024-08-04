resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_block
  tags = {
    Name=var.vpc
  }
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.sub1_block
  availability_zone = var.sub1_zone
  map_public_ip_on_launch = true
  tags = {
    Name=var.sub1
  }
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.sub2_block
  availability_zone = var.sub2_zone
  map_public_ip_on_launch = true
  tags = {
    Name=var.sub2
      }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name=var.igw
  }
}

resource "aws_route_table" "rtb" {
  vpc_id=aws_vpc.my_vpc.id
  route{
    cidr_block=var.route_black
    gateway_id=aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "sub1rt" {
  route_table_id = aws_route_table.rtb.id
  subnet_id = aws_subnet.sub1.id
}

resource "aws_route_table_association" "sub2rt" {
  route_table_id = aws_route_table.rtb.id
  subnet_id = aws_subnet.sub2.id
}

