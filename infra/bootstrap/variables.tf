variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "memos-tfstate-devopsbyhassan-eu-west-2"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}