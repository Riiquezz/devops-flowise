provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.eks_cluster_name
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  desired_capacity = var.eks_desired_capacity
  max_capacity     = var.eks_max_capacity
  min_capacity     = var.eks_min_capacity
}

module "rds" {
  source              = "./modules/rds"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  db_name             = var.rds_db_name
  username            = var.rds_username
  password            = var.rds_password
  allowed_cidr_blocks = var.rds_allowed_cidr_blocks
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "datadog" {
  source = "./modules/datadog"

  datadog_api_key         = var.datadog_api_key
  datadog_app_key         = var.datadog_app_key
  aws_account_id          = var.aws_account_id
  datadog_integration_role = var.datadog_integration_role
}

module "waf" {
  source = "./modules/waf"

  waf_name     = "flowise-waf"
  resource_arn = aws_lb.main.arn
}
