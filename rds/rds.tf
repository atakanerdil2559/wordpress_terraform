resource "aws_db_instance" "rds-db" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  identifier           = "${var.env}-my-db"
  name                 = var.database_name
  username             = var.username
  password             = random_password.password.result
  skip_final_snapshot = var.skip_snapshot
  final_snapshot_identifier = var.skip_snapshot == true ? null : "${var.env}-rds-snapshot"
  vpc_security_group_ids    = [ aws_security_group.rds-sg.id ]
}

resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "rds-subnet-grp"
  description = "rds subnet group"
  subnet_ids  = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  tags {
      Name = "${var.env}-rds-subnet grp"
  }
}