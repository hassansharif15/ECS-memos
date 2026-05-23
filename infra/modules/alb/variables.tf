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

variable "public_subnet_ids" {
  description = "Public subnet IDs for ALB"
  type        = list(string)
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 5230
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
}
