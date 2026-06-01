variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS"
  type        = list(string)
}

variable "ecs_security_group_id" {
  description = "ECS security group ID - only this can talk to RDS"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "memos"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "memos"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}
