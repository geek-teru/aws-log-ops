# S3 Buckets
resource "aws_s3_bucket" "logs_bucket" {
  bucket              = "${var.aws_account_id}-${var.env}-${var.sys_name}-logs-bucket"
  object_lock_enabled = true

  force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "logs_bucket_encryption" {
  bucket = aws_s3_bucket.logs_bucket.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256" // SSE-S3
    }
  }
}

resource "aws_s3_bucket_public_access_block" "logs_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.logs_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "logs_bucket_policy" {
  bucket = aws_s3_bucket.logs_bucket.id
  policy = templatefile("${path.module}/policies/system-logs-bucket-policy.json", {
    bucket_arn = aws_s3_bucket.logs_bucket.arn,
    account_id = var.aws_account_id
  })
}

output "logs_bucket" {
  value = aws_s3_bucket.logs_bucket
}
