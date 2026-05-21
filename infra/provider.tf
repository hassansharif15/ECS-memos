terraform {
  required_version = ">= 1.14.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  
  backend "s3" {
    bucket       = "memos-tfstate-devopsbyhassan-eu-west-2"
    key          = "memos/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "memos"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}