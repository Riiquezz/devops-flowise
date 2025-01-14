variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of instances in the node group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of instances in the node group"
  type        = number
  default     = 5
}

variable "min_capacity" {
  description = "Minimum number of instances in the node group"
  type        = number
  default     = 1
}
