variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1" # Fallback in case the environment variable is not set
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_desired_capacity" {
  description = "Desired number of EKS nodes"
  type        = number
}

variable "eks_max_capacity" {
  description = "Maximum number of EKS nodes"
  type        = number
}

variable "eks_min_capacity" {
  description = "Minimum number of EKS nodes"
  type        = number
}

variable "rds_db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "rds_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "rds_password" {
  description = "Password for the RDS database"
  type        = string
}

variable "rds_allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for RDS access"
  type        = list(string)
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "datadog_api_key" {
  description = "API Key for Datadog"
  type        = string
}

variable "datadog_app_key" {
  description = "App Key for Datadog"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID for Datadog integration"
  type        = string
}

variable "datadog_integration_role" {
  description = "IAM Role for Datadog integration"
  type        = string
}

variable "alb_arn" {
  description = "ARN of the Application Load Balancer"
  type        = string
}
