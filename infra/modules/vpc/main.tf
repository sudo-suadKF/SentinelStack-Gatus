# VPC
resource "aws_vpc" "vpc-gatus" {
  cidr_block = var.vpc-cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-gatus"
  }
}

# Public Subnets
resource "aws_subnet" "public-subnet1" {
  vpc_id = aws_vpc.vpc-gatus.id
  cidr_block = var.public-subnet1-cidr
  availability_zone = var.az1

  tags = {
    Name = var.public-subnet1-tags
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id = aws_vpc.vpc-gatus.id
  cidr_block = var.public-subnet2-cidr
  availability_zone = var.az2

  tags = {
    Name = var.public-subnet2-tags
  }
}

resource "aws_subnet" "public-subnet3" {
  vpc_id = aws_vpc.vpc-gatus.id
  cidr_block = var.public-subnet3-cidr
  availability_zone = var.az3

  tags = {
    Name = var.public-subnet3-tags
  }
}
########################################################################

# Private Subnets
resource "aws_subnet" "private-subnet1" {
  vpc_id = aws_vpc.vpc-gatus.id
  cidr_block = var.private-subnet1-cidr
  availability_zone = var.az1

  tags = {
    Name = var.private-subnet1-tags
  }
}

resource "aws_subnet" "private-subnet2" {
  vpc_id = aws_vpc.vpc-gatus.id
  cidr_block = var.private-subnet2-cidr
  availability_zone = var.az2

  tags = {
    Name = var.private-subnet2-tags
  }
}

resource "aws_subnet" "private-subnet3" {
  vpc_id = aws_vpc.vpc-gatus.id
  cidr_block = var.private-subnet3-cidr
  availability_zone = var.az3

  tags = {
    Name = var.private-subnet3-tags
  }
}
########################################################################

# IGW
resource "aws_internet_gateway" "igw-gatus" {
  vpc_id = aws_vpc.vpc-gatus.id

  tags = {
    Name = var.igw-tags
  }
}

# NAT GW
resource "aws_nat_gateway" "nat-gw-gatus" {
  availability_mode = var.nat-gw-availability-mode
  connectivity_type = var.nat-gw-connectivity-type
  vpc_id = aws_vpc.vpc-gatus.id 

  tags = {
    Name = var.nat-gw-tags
  }

  depends_on = [aws_internet_gateway.igw-gatus]
}
########################################################################

# Route tables - Public subnets to IGW
resource "aws_route_table" "Public-RT" {
  vpc_id = aws_vpc.vpc-gatus.id

  route {
    cidr_block = var.internet-cidr
    gateway_id = aws_internet_gateway.igw-gatus.id
  }

  tags = {
    Name = var.public-rt-tags
  }
}

resource "aws_route_table_association" "Public-RT-subnet1" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.Public-RT.id
}

resource "aws_route_table_association" "Public-RT-subnet2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.Public-RT.id
}

resource "aws_route_table_association" "Public-RT-subnet3" {
  subnet_id      = aws_subnet.public-subnet3.id
  route_table_id = aws_route_table.Public-RT.id
}
########################################################################

#Route table - Private subnets to NAT GW
resource "aws_route_table" "Private-RT" {
  vpc_id = aws_vpc.vpc-gatus.id

  route {
    cidr_block = var.internet-cidr
    gateway_id = aws_nat_gateway.nat-gw-gatus.id
  }

  tags = {
    Name = var.private-rt-tags
  }
}

resource "aws_route_table_association" "Private-RT-subnet1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.Private-RT.id
}

resource "aws_route_table_association" "Private-RT-subnet2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.Private-RT.id
}

resource "aws_route_table_association" "Private-RT-subnet3" {
  subnet_id      = aws_subnet.private-subnet3.id
  route_table_id = aws_route_table.Private-RT.id
}
########################################################################

