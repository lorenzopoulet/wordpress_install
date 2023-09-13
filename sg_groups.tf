resource "aws_security_group" "alb_security_group" {
  name        = "alb_security_group"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc.id

  # Règle autorisant le trafic HTTP (port 80) et HTTPS (port 443) depuis n'importe quelle source
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_security_group" {
  name        = "ssh_security_group"
  description = "Security group for SSH access"
  vpc_id      = aws_vpc.vpc.id

  # Règle autorisant le trafic SSH (port 22) depuis n'importe quelle source
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "webserver_security_group" {
  name        = "webserver_security_group"
  description = "Security group for the web server"
  vpc_id      = aws_vpc.vpc.id

  # Règle autorisant le trafic HTTP (port 80) et HTTPS (port 443) depuis le groupe de sécurité ALB
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_security_group.id]
  }

  # Règle autorisant le trafic SSH (port 22) depuis le groupe de sécurité SSH
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh_security_group.id]
  }
}

resource "aws_security_group" "database_security_group" {
  name        = "database_security_group"
  description = "Security group for database access"
  vpc_id      = aws_vpc.vpc.id

  # Règle autorisant le trafic MySQL (port 3306) depuis le groupe de sécurité Webserver
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_security_group.id]
  }
}

resource "aws_security_group" "efs_security_group" {
  name        = "efs_security_group"
  description = "Security group for EFS access"
  vpc_id      = aws_vpc.vpc.id

  # Règle autorisant le trafic SSH (port 22) depuis le groupe de sécurité SSH
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ssh_security_group.id]
  }

  # Règle autorisant le trafic NFS (port 2049) depuis le groupe de sécurité Webserver et EFS
  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_security_group.id]
  }
}
  