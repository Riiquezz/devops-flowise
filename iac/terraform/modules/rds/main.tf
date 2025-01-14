resource "aws_db_instance" "primary" {
  allocated_storage      = var.allocated_storage
  engine                 = "postgres"
  engine_version         = "13.4"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  publicly_accessible = false

  tags = {
    Name = "primary-rds"
  }
}

resource "aws_db_snapshot" "primary_snapshot" {
  db_instance_identifier = aws_db_instance.primary.id
  db_snapshot_identifier = "${var.db_name}-snapshot"
}

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}

resource "aws_db_instance" "secondary" {
  provider                = aws.secondary
  allocated_storage       = var.allocated_storage
  engine                  = "postgres"
  engine_version          = "13.4"
  instance_class          = "db.t3.micro"
  snapshot_identifier     = aws_db_snapshot.primary_snapshot.id
  vpc_security_group_ids  = [aws_security_group.rds_secondary.id]
  db_subnet_group_name    = aws_db_subnet_group.secondary.name

  publicly_accessible = false

  tags = {
    Name = "secondary-rds"
  }
}

resource "aws_security_group" "rds_secondary" {
  provider = aws.secondary
  vpc_id   = var.secondary_vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "secondary" {
  provider   = aws.secondary
  name       = "rds-secondary-subnet-group"
  subnet_ids = var.secondary_subnet_ids

  tags = {
    Name = "rds-secondary-subnet-group"
  }
}
