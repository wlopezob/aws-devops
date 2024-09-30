resource "aws_vpc" "vpc-main" {
  cidr_block = var.cidr_block-vpc
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name_prefix}-vpc"
  }
}

resource "aws_subnet" "sb-public-01" {
  vpc_id                                      = aws_vpc.vpc-main.id
  cidr_block                                  = var.cidr_block-sb-public01
  availability_zone                           = var.az-public01
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch                     = true
  tags = {
    Name = "${var.project_name_prefix}-sb-${var.name-az-public01}"
  }
}

resource "aws_subnet" "sb-private-01" {
  vpc_id            = aws_vpc.vpc-main.id
  cidr_block        = var.cidr_block-sb-private01
  availability_zone = var.az-private01

  tags = {
    Name = "${var.project_name_prefix}-sb-${var.name-az-private01}"
  }
}

### IGW ###
resource "aws_internet_gateway" "igw-main" {
  vpc_id = aws_vpc.vpc-main.id

  tags = {
    Name = "${var.project_name_prefix}-igw"
  }
}

## IP ###
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name_prefix}-eip"
  }
}

### NAT ###
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.sb-public-01.id
  tags = {
    Name = "${var.project_name_prefix}-nat"
  }
}


resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vpc-main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-main.id
  }
  tags = {
    Name = "${var.project_name_prefix}-rt-public"
  }
}

resource "aws_route_table" "rt-private" {
  vpc_id = aws_vpc.vpc-main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.project_name_prefix}-rt-private"
  }
}

resource "aws_route_table_association" "rta-public-01" {
  subnet_id      = aws_subnet.sb-public-01.id
  route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "rta-private-01" {
  subnet_id      = aws_subnet.sb-private-01.id
  route_table_id = aws_route_table.rt-private.id
}