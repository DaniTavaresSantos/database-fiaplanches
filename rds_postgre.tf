terraform {
  cloud {
    organization = "fiap-lanches-organization"

    workspaces {
      name = "fiap-lanches-workspace"
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
  vpc_id      = "vpc-095eb68b72c27e87b"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = ["sg-07fafcaf17d707178"]
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
  subnet_ids  = ["subnet-0719b6a5d9d281b31", "subnet-0d11eb1ee35634bec"]
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