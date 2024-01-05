##Security group for buildserver
resource "aws_security_group" "buildserver_sg" {
  name        = "Buildserver SG"
  description = "Security group for build server"
  vpc_id      = aws_vpc.staging_vpc.id

  ingress {
    description = "Open SSH port for VPN IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.2.1/32"]
  }
  ingress {
    description = "Open konga port for VPN IP"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["192.168.2.1/32"]
  }
  ingress {
    description = "Open SSH port for VPN IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.3.1/32"]
  }
  ingress {
    description = "Open konga port for VPN IP"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["192.168.3.1/32"]
  }
  ingress {
    description = "HTTP to public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTPS to public"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
    Name    = "Staging BuildServer SG-${var.project_name}"
  })
}

##Security group for DB-Server
resource "aws_security_group" "db_server_sg" {
  name        = "DB Server SG"
  description = "Security group for db server"
  vpc_id      = aws_vpc.staging_vpc.id

  ingress {
    description = "Open SSH port for VPN IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.2.1/32"]
  }
  ingress {
    description = "Open Mongo port for VPN IP"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["192.168.2.1/32"]
  }
  ingress {
    description = "Open MySql port for VPN IP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["192.168.2.1/32"]
  }
  ingress {
    description = "Open SSH port for VPN IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.3.1/32"]
  }
  ingress {
    description = "Open Mongo port for VPN IP"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["192.168.3.1/32"]
  }
  ingress {
    description = "Open MySql port for VPN IP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["192.168.3.1/32"]
  }
  ingress {
    description = "Open Mongo port for API Server"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.staging_vpc.cidr_block]
  }
  ingress {
    description = "Open MySql port for API Server"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.staging_vpc.cidr_block]
  }
  ingress {
    description = "Open Cassandra port for API Server"
    from_port   = 9042
    to_port     = 9042
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.staging_vpc.cidr_block]
  }
  ingress {
    description = "Open Kafka port for API Server"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.staging_vpc.cidr_block]
  }
  ingress {
    description = "Open Redis port for API Server"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.staging_vpc.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(var.tags, {
    Name    = "Staging DB-Server SG-${var.project_name}"
  })
}
