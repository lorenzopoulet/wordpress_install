
resource "aws_instance" "ec2_AZ1" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  key_name        = "my_key.pub"
  subnet_id       = aws_subnet.private_subnets_AZ1[0].id
  security_groups = [aws_security_group.webserver_security_group.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "EC2-instance_AZ1"
  }
}

resource "aws_instance" "ec2_AZ2" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  key_name        = "my_key.pub"
  subnet_id       = aws_subnet.private_subnets_AZ1[0].id
  security_groups = [aws_security_group.webserver_security_group.id]
  tags = {
    Name = "EC2-instance_AZ2"
  }
}
