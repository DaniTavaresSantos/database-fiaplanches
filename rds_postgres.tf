terraform {
  cloud {
    organization = "fiap-lanches-organization"

    workspaces {
      name = "rds-postgres-workspace"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_security_group" "database_security_group" {
  name        = "${var.environment}-rds-postgres-sg"
  description = "Liberacao da porta 5432 para acesso ao rds postgres"
  vpc_id      = "vpc-09e3f166315e834e1"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["sg-00038346ce46cda2c"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = "${var.environment}-rds-postgres"
  }
}

resource "aws_db_subnet_group" "database_subnet_group" {
  name        = "${var.app_name}-rds-postgres-subnets"
  subnet_ids  = ["subnet-038009815a72bc6eb", "subnet-064207d0dbbec7e0a"]
  description = "Subnets para o rds postgres"

  tags = {
    Name = "${var.app_name}-subnet-rds-postgres"
  }
}

resource "aws_db_instance" "db_instance" {
  engine                 = "postgres"
  engine_version         = "14"
  multi_az               = false
  identifier             = "${var.environment}-rds-postgres"
  username               = "fiap_lanches"
  password               = "fiaplanches123"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  db_subnet_group_name   = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids = [aws_security_group.database_security_group.id]
  availability_zone      = data.aws_availability_zones.available.names[0]
  db_name                = "fiaplanches"
  skip_final_snapshot    = true
}
