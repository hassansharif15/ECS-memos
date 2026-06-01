output "db_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.main.endpoint
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.main.db_name
}

output "db_username" {
  description = "Database username"
  value       = aws_db_instance.main.username
}

output "db_secret_arn" {
  description = "ARN of the secret containing the DB password"
  value       = aws_secretsmanager_secret.db_password.arn
}

output "rds_security_group_id" {
  description = "RDS security group ID"
  value       = aws_security_group.rds.id
}

output "db_connection_string" {
  description = "PostgreSQL connection string for memos"
  value       = "postgres://${var.db_username}:${urlencode(random_password.db_password.result)}@${aws_db_instance.main.endpoint}/${var.db_name}?sslmode=require"
  sensitive   = true
}