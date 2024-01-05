##Create VPC
resource "aws_vpc" "staging_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = merge(var.tags, {
    Name = "Staging_VPC"
  })
}
##Create subnet 1
resource "aws_subnet" "staging_subnet_1" {
  vpc_id            = aws_vpc.staging_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.aws_region}a"
  tags = merge(var.tags, {
    Name = "staging_subnet_1"
  })
}
##Create subnet 2
resource "aws_subnet" "staging_subnet_2" {
  vpc_id            = aws_vpc.staging_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}b"
  tags = merge(var.tags, {
    Name = "staging_subnet_2"
  })
}

##Create Internet gateway
resource "aws_internet_gateway" "staging_igw" {
  vpc_id = aws_vpc.staging_vpc.id
}

##Route tabe
resource "aws_route_table" "staging_route_table" {
  vpc_id = aws_vpc.staging_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.staging_igw.id
  }
}

resource "aws_route_table_association" "staging_association_1" {
  subnet_id      = aws_subnet.staging_subnet_1.id
  route_table_id = aws_route_table.staging_route_table.id
}

resource "aws_route_table_association" "staging_association_2" {
  subnet_id      = aws_subnet.staging_subnet_2.id
  route_table_id = aws_route_table.staging_route_table.id
}
