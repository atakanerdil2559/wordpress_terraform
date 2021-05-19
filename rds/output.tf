output "rds_id" {
  value       = aws_db_instance.rds-db.id
  description = "id of rds database"
}
output "rds_password" {
  value = random_password.password.result
}

output "rds_db_username" {
  value = aws_db_instance.rds-db.username
}

output "rds_endpoint" {
  value = aws_db_instance.rds-db.address
}