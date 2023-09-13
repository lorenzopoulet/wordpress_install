
resource "aws_vpc" "vpc" {
  cidr_block         = var.vpc_cidr
  enable_dns_support = true

}

resource "aws_subnet" "public_subnets" {
  count             = var.subnets_nb
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Public_Subnet_AZ${count.index + 1}"
  }

}

resource "aws_subnet" "private_subnets_AZ1" {
  count             = var.subnets_nb
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private_Subnet_AZ1"
  }

}

resource "aws_subnet" "private_subnets_AZ2" {
  count             = var.subnets_nb
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + 4)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Private_Subnet_AZ2"
  }

}


resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.vpc.id
}







resource "aws_nat_gateway" "nat_gw" {
  for_each = {
    0 = "${aws_subnet.public_subnets[0].id}"
    1 = "${aws_subnet.public_subnets[1].id}"
  }
  allocation_id = aws_eip.eip[each.key].id
  subnet_id     = each.value

  tags = {
    Name = "NAT_gw"
  }
}

resource "aws_eip" "eip" {
  count      = 2
  depends_on = [aws_internet_gateway.internet_gw]
}