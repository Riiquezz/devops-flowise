variable "vpc_id" {
  description = "VPC ID for the RDS instance"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Database username"
  type        = string
}

variable "password" {
  description = "Database password"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for RDS access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
