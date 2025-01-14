# Provedor AWS Primário (para a região principal)
provider "aws" {
  region = var.aws_region
}

# Provedor AWS Secundário (para a região secundária)
provider "aws" {
  alias  = "secondary"
  region = var.rds_secondary_region  # Região secundária para replicação do RDS
}

# Módulo VPC
module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

# Módulo EKS
module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.eks_cluster_name
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = concat(module.vpc.public_subnet_ids, module.vpc.private_subnet_ids)
  desired_capacity = var.eks_desired_capacity
  max_capacity     = var.eks_max_capacity
  min_capacity     = var.eks_min_capacity
}

# Módulo RDS - Banco de Dados com Réplica Multi-Region
module "rds" {
  source               = "./modules/rds"
  primary_vpc_id       = module.vpc.vpc_id
  primary_subnet_ids   = module.vpc.private_subnet_ids
  db_name              = var.rds_db_name
  username             = var.rds_username
  password             = var.rds_password
  allocated_storage    = var.rds_allocated_storage
  allowed_cidr_blocks  = var.rds_allowed_cidr_blocks
  secondary_region     = var.rds_secondary_region
  secondary_vpc_id     = var.secondary_vpc_id
  secondary_subnet_ids = var.secondary_subnet_ids
}

# Módulo S3 - Bucket Primário e Replica Multi-Region
module "s3" {
  source             = "./modules/s3"
  bucket_name        = var.s3_bucket_name
  replica_bucket_arn = var.s3_replica_bucket_arn
}

# Módulo WAF
module "waf" {
  source = "./modules/waf"

  waf_name     = "flowise-waf"
  resource_arn = aws_lb.main.arn  # Se precisar de um load balancer, substitua isso
}
