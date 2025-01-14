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

  tags = {
    Name = var.bucket_name
  }
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}
