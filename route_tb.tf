resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id

  }

  tags = {
    Name = "Public_route_table"
  }
}

resource "aws_route_table_association" "public_rtb_assoc" {
  for_each = {
    Public_AZ1 = "${aws_subnet.public_subnets[0].id}"
    Public_AZ2 = "${aws_subnet.public_subnets[1].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rtb.id


}

resource "aws_route_table" "private_rtb_AZ1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id // Go nat gw

  }

  tags = {
    Name = "Private_route_table"
  }
}

resource "aws_route_table" "private_rtb_AZ2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id // Go nat gw

  }

  tags = {
    Name = "Private_route_table_AZ1"
  }
}

resource "aws_route_table_association" "private_rtbAZ1_assoc" {
  for_each = {
    Private_AZ1a = "${aws_subnet.private_subnets_AZ1[0].id}"
    Private_AZ1b = "${aws_subnet.private_subnets_AZ1[1].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb_AZ1.id


}

resource "aws_route_table_association" "private_rtbAZ2_assoc" {
  for_each = {
    Private_AZ2a = "${aws_subnet.private_subnets_AZ2[0].id}"
    Private_AZ2b = "${aws_subnet.private_subnets_AZ2[1].id}"
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb_AZ2.id


}