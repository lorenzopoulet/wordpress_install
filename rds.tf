resource "aws_db_instance" "rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_name                = "exampledb"
  username               = "haroon"
  password               = "defaultPw"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_gp.name
}


resource "aws_db_subnet_group" "db_subnet_gp" {
  name        = "example-subnet-group"
  description = "DB subnet group"
  subnet_ids = [
    aws_subnet.private_subnets_AZ1[1].id,
    aws_subnet.private_subnets_AZ2[1].id,
  ]
}

