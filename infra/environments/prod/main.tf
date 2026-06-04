terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

module "vpc" {
  source = "../../modules/vpc"

  project              = var.project
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.project
}

module "iam" {
  source = "../../modules/iam"

  project     = var.project
  environment = var.environment
}

module "acm" {
  source = "../../modules/acm"

  project        = var.project
  environment    = var.environment
  domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
}

module "alb" {
  source = "../../modules/alb"

  project           = var.project
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = var.container_port
  certificate_arn   = module.acm.certificate_arn
}

module "rds" {
  source = "../../modules/rds"

  project               = var.project
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnet_ids
  ecs_security_group_id = module.ecs.ecs_security_group_id
  db_instance_class     = var.db_instance_class
  db_allocated_storage  = var.db_allocated_storage
  multi_az              = var.multi_az
}

module "ecs" {
  source = "../../modules/ecs"

  project                     = var.project
  environment                 = var.environment
  aws_region                  = var.aws_region
  vpc_id                      = module.vpc.vpc_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  container_port              = var.container_port
  ecs_cpu                     = var.ecs_cpu
  ecs_memory                  = var.ecs_memory
  desired_count               = var.desired_count
  repository_url              = module.ecr.repository_url
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  alb_security_group_id       = module.alb.alb_security_group_id
  target_group_arn            = module.alb.target_group_arn
  db_driver                   = "postgres"
  db_connection               = module.rds.db_connection_string
}

module "route53" {
  source = "../../modules/route53"

  hosted_zone_id = var.hosted_zone_id
  domain_name    = var.domain_name
  alb_dns_name   = module.alb.alb_dns_name
  alb_zone_id    = module.alb.alb_zone_id
}