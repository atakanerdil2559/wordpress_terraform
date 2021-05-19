resource "aws_db_instance" "rds-db" {
  allocated_storage         = 10
  storage_type              = "gp2"
  engine                    = "mariadb"
  engine_version            = "10.5"
  instance_class            = var.instance_class
  identifier                = "${var.env}-my-db"
  name                      = "my-rds"
  username                  = "admin"
  password                  = random_password.password.result
  skip_final_snapshot       = var.skip_snapshot
  final_snapshot_identifier = var.skip_snapshot == true ? null : "${var.env}-rds-snapshot"
  vpc_security_group_ids    = [data.terraform_remote_state.vpc.outputs.rds_sg_id]
  publicly_accessible       = var.env == "dev" ? true : false
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_rds"
    }
  )
}

resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "rds-subnet-grp"
  description = "rds subnet group"
  subnet_ids  = [data.terraform_remote_state.vpc.outputs.private_subnets_ids]
  tags = merge(
    local.common_tags,
    {
      Name = "${var.env}_subnet_grp"
    }
  )
}