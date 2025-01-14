variable "bucket_name" {
  description = "Name of the primary S3 bucket"
  type        = string
}

variable "replica_bucket_arn" {
  description = "ARN of the replica S3 bucket in the secondary region"
  type        = string
}
