output "rds_id" {
  value = aws_security_group.rds.id
  description = "id of rds database"
}