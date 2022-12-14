# Internet VPC
resource "aws_vpc" "openvpn_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "OpenVpn Terraform"
  }
}

# Subnets
resource "aws_subnet" "openvpn-public-1" {
  vpc_id                  = aws_vpc.openvpn_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "OpenVpn Public 1"
  }
}

resource "aws_subnet" "openvpn-public-2" {
  vpc_id                  = aws_vpc.openvpn_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "OpenVpn Public 2"
  }
}

resource "aws_subnet" "openvpn-public-3" {
  vpc_id                  = aws_vpc.openvpn_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "OpenVpn Public 3"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.openvpn_vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "main-private-1"
  }
}


# Internet GW
resource "aws_internet_gateway" "openvpn-gw" {
  vpc_id = aws_vpc.openvpn_vpc.id

  tags = {
    Name = "OpenVpn IGW"
  }
}

# route tables
resource "aws_route_table" "openvpn-public" {
  vpc_id = aws_vpc.openvpn_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.openvpn-gw.id
  }

  tags = {
    Name = "OpenVpn Public 1"
  }
}

# route associations public
resource "aws_route_table_association" "openvpn-public-1-a" {
  subnet_id      = aws_subnet.openvpn-public-1.id
  route_table_id = aws_route_table.openvpn-public.id
}

resource "aws_route_table_association" "openvpn-public-2-a" {
  subnet_id      = aws_subnet.openvpn-public-2.id
  route_table_id = aws_route_table.openvpn-public.id
}

resource "aws_route_table_association" "openvpn-public-3-a" {
  subnet_id      = aws_subnet.openvpn-public-3.id
  route_table_id = aws_route_table.openvpn-public.id
}

