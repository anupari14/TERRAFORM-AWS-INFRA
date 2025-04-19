resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.environment}-rds-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.environment}-rds-sg"
  description = "Allow PostgreSQL access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-rds-sg"
  }
}

resource "aws_db_instance" "postgres" {
  identifier         = "${var.environment}-postgres-db"
  engine             = "postgres"
  engine_version     = "14"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  storage_encrypted  = true

  db_name            = var.db_name
  username           = var.username
  password           = var.password
  port               = 5432

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name = "${var.environment}-postgres-db"
  }
}

resource "null_resource" "init_schemas" {
  depends_on = [aws_db_instance.postgres]

  provisioner "local-exec" {
    command = <<EOT
PGPASSWORD=${var.password} psql -h ${aws_db_instance.postgres.address} -U ${var.username} -d ${var.db_name} -p 5432 -c "CREATE SCHEMA IF NOT EXISTS \"as-is-data-schema\";"
PGPASSWORD=${var.password} psql -h ${aws_db_instance.postgres.address} -U ${var.username} -d ${var.db_name} -p 5432 -c "CREATE SCHEMA IF NOT EXISTS \"curated-data-schema\";"
EOT
  }
}
