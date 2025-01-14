resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire-older-versions"
    enabled = true
    noncurrent_version_expiration {
      days = 30
    }
  }

  replication_configuration {
    role = aws_iam_role.replication_role.arn

    rules {
      id     = "ReplicationRule"
      status = "Enabled"

      destination {
        bucket        = var.replica_bucket_arn
        storage_class = "STANDARD"
      }
    }
  }

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_iam_role" "replication_role" {
  name = "s3-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}
