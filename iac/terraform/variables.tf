# Região principal para os recursos
variable "aws_region" {
  description = "Região principal para a infraestrutura"
  type        = string
}

# Região secundária para replicação do RDS e S3
variable "rds_secondary_region" {
  description = "Região secundária para replicação do RDS"
  type        = string
}

# Configuração da VPC
variable "vpc_cidr_block" {
  description = "CIDR para a VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "CIDRs para sub-redes públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs para sub-redes privadas"
  type        = list(string)
}

variable "availability_zones" {
  description = "Zonas de disponibilidade para a VPC"
  type        = list(string)
}

# Configuração do EKS
variable "eks_cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "eks_desired_capacity" {
  description = "Capacidade desejada do EKS"
  type        = number
}

variable "eks_max_capacity" {
  description = "Capacidade máxima do EKS"
  type        = number
}

variable "eks_min_capacity" {
  description = "Capacidade mínima do EKS"
  type        = number
}

# Configuração do RDS
variable "rds_db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "rds_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "rds_password" {
  description = "Senha do banco de dados"
  type        = string
}

variable "rds_allocated_storage" {
  description = "Armazenamento alocado para o RDS"
  type        = number
  default     = 20
}

variable "rds_allowed_cidr_blocks" {
  description = "CIDR Blocks permitidos para o RDS"
  type        = list(string)
}

# VPC na região secundária
variable "secondary_vpc_id" {
  description = "ID da VPC na região secundária"
  type        = string
}

# Subnets na região secundária
variable "secondary_subnet_ids" {
  description = "IDs das sub-redes privadas na região secundária"
  type        = list(string)
}

# Configuração do S3
variable "s3_bucket_name" {
  description = "Nome do bucket S3 primário"
  type        = string
}

variable "s3_replica_bucket_arn" {
  description = "ARN do bucket S3 na região secundária"
  type        = string
}

# Configuração do WAF
variable "waf_name" {
  description = "Nome do WAF"
  type        = string
}

# Configuração do Datadog
variable "datadog_api_key" {
  description = "Chave de API para o Datadog"
  type        = string
}

variable "datadog_app_key" {
  description = "Chave de aplicação para o Datadog"
  type        = string
}

variable "aws_account_id" {
  description = "ID da conta AWS"
  type        = string
}

variable "datadog_integration_role" {
  description = "Role para integração do Datadog"
  type        = string
}
