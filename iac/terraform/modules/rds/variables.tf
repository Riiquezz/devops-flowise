variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "username" {
  description = "Username for the RDS database"
  type        = string
}

variable "password" {
  description = "Password for the RDS database"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for RDS"
  type        = number
  default     = 20
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access RDS"
  type        = list(string)
}

variable "primary_vpc_id" {
  description = "VPC ID for primary region"
  type        = string
}

variable "primary_subnet_ids" {
  description = "Subnet IDs for primary region"
  type        = list(string)
}

variable "secondary_region" {
  description = "Secondary region for RDS"
  type        = string
}

variable "secondary_vpc_id" {
  description = "VPC ID for secondary region"
  type        = string
}

variable "secondary_subnet_ids" {
  description = "Subnet IDs for secondary region"
  type        = list(string)
}
