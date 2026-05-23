output "repository_url" {
  description = "ECR repository URL"
  value       = data.aws_ecr_repository.main.repository_url
}

output "repository_name" {
  description = "ECR repository name"
  value       = data.aws_ecr_repository.main.name
}

output "repository_arn" {
  description = "ECR repository ARN"
  value       = data.aws_ecr_repository.main.arn
}